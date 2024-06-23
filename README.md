# neollama.vim

A Neovim Plugin for AI Language Modeling

## Status

_Experimental_

## Requirement

- Ollama
- curl
- granite-code:3b model

## Install via Lazy Vim.

```lua
-- lazy.nvim
return {
  "vczb/neollama.vim",
  config = function()
    local neollama = require("neollama")
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
