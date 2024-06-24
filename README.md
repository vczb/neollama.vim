# neollama.vim

A Neovim Plugin for AI Language Modeling

## Status

_Ready to use (may contain bugs)_

## Requirement

- [Ollama](https://www.ollama.com/)
- [LLM model](https://www.ollama.com/library)
- [curl](https://github.com/curl/curl)

## Install via Lazy Vim.

```lua
-- lazy.nvim
return {
    "vczb/neollama.vim",
    config = function()
        local neollama = require("neollama")
        --[[
            -- set a custom model
            neollama.setup({ model = "my-model-name"}) -- default granite-code:3b
        --]]
        neollama.setup()
    end,
}
```

## Available commands

Here's the refactored "Commands" section in a Markdown table format:

## Available Commands

| Command          | Description                                   | Arguments |
| ---------------- | --------------------------------------------- | --------- |
| `OllamaChat`     | Chat with Ollama                              | 1 string  |
| `OllamaReset`    | Reset Ollama context                          | None      |
| `OllamaReadFile` | Read the current file and add to chat context | None      |

## License

[MIT](./LICENSE)
