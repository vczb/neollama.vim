# neollama.vim

A Neovim Plugin for AI Language Modeling

## Status

_Experimental_

## Requirement

- Ollama
- curl
- llm model

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

| Command                 | Description                                   | Arguments |
| ----------------------- | --------------------------------------------- | --------- |
| `OllamaChat`            | Chat with Ollama                              | 1 string  |
| `OllamaReset`           | Reset Ollama context                          | None      |
| _BUG:_ `OllamaReadFile` | Read the current file and add to chat context | None      |

## License

[MIT](./LICENSE)
