local M = {}

function M.setup(opts)
   opts = opts or {}
end

local chat_context = {}

local reset_context = function()
   chat_context = {}
end

local create_job = function(endpoint, json_payload, on_finish)
   local Job = require("plenary.job")
   Job:new({
      command = "curl",
      args = { "-s", endpoint, "-d", json_payload },
      on_exit = function(self, code, signal)
         local result = self:result()
         on_finish(result)
      end,
   }):start()
end

local handle_chat_response = function(result)
   vim.schedule(function()
      local data = vim.fn.json_decode(table.concat(result, ""))
      if data.context then
         chat_context = data.context
      end
      local chat_response = data.response:gsub("%. ", ".\n"):gsub("\n", "\n\n")
      vim.api.nvim_put(vim.split(chat_response, "\n"), "b", true, true)
      vim.api.nvim_command("normal! o")
   end)
end

local read_file = function()
   local buf = vim.api.nvim_get_current_buf()
   local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
   local content = table.concat(lines, "\n")

   local json_prompt = vim.fn.json_encode({
      model = "granite-code:3b",
      prompt = "CONTEXT: You are an IA assistant with solve programming problems. Memorize this file I will ask you questions about it later: "
         .. content,
      context = chat_context,
      stream = false,
   })

   create_job(
      "http://localhost:11434/api/generate",
      json_prompt,
      handle_chat_response
   )
end

-- TODO: Create code-completion feature

-- local code_complete = function()
--   local line = vim.api.nvim_get_current_line()
--
--   local json_payload = vim.fn.json_encode({
--     model = "granite-code:3b",
--     messages = {
--       { role = "assistant", content = line },
--     },
--   })
--
--   create_job("http://localhost:11434/api/chat", json_payload, function(result)
--     vim.schedule(function()
--       local data = vim.fn.json_decode(table.concat(result, ""))
--       vim.api.nvim_put(vim.split(data.message.content, "\n"), "b", true, true)
--     end)
--   end)
-- end

local chat = function(opts)
   local prompt = "CONTEXT: You are an IA assistant with solve programming problems. When I ask you to resolve an algorithm, just say the awnser. PROBLEM TO SOLVE: "
      .. opts.args

   local json_prompt = vim.fn.json_encode({
      model = "granite-code:3b",
      prompt = prompt,
      context = chat_context,
      stream = false,
   })

   create_job(
      "http://localhost:11434/api/generate",
      json_prompt,
      handle_chat_response
   )
end

local create_command = vim.api.nvim_create_user_command

-- create_command("OllamaCodeComplete", code_complete, {})
create_command("OllamaChat", chat, { nargs = 1, desc = "Chat with Ollama" })
create_command(
   "OllamaReset",
   reset_context,
   { nargs = 0, desc = "Reset Ollama context" }
)
create_command(
   "OllamaReadFile",
   read_file,
   { nargs = 0, desc = "Read the current file and add to chat context" }
)

return M

