return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {
          cmd = { "vscode-css-language-server", "--stdio" },
          settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
          },
        },
        html = {
          cmd = { "vscode-html-language-server", "--stdio" },
          settings = {
            html = {
              format = { wrapLineLength = 120, unformatted = "pre,code" },
            },
          },
        },
        jsonls = {
          cmd = { "vscode-json-language-server", "--stdio" },
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
