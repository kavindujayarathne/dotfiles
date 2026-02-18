return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdown-toc" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "markdown-toc" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = true,
      },
      -- callout = {
      --   note = {
      --     raw = "[!NOTE]",
      --     rendered = "󰋽 Note",
      --     highlight = "RenderMarkdownInfo",
      --     category = "github",
      --   },
      --   tip = {
      --     raw = "[!TIP]",
      --     rendered = "󰌶 Tip",
      --     highlight = "RenderMarkdownSuccess",
      --     category = "github",
      --   },
      --   important = {
      --     raw = "[!IMPORTANT]",
      --     rendered = "󰅾 Important",
      --     highlight = "RenderMarkdownHint",
      --     category = "github",
      --   },
      --   warning = {
      --     raw = "[!WARNING]",
      --     rendered = "󰀪 Warning",
      --     highlight = "RenderMarkdownWarn",
      --     category = "github",
      --   },
      --   caution = {
      --     raw = "[!CAUTION]",
      --     rendered = "󰳦 Caution",
      --     highlight = "RenderMarkdownError",
      --     category = "github",
      --   },
      --   -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
      --   abstract = {
      --     raw = "[!ABSTRACT]",
      --     rendered = "󰨸 Abstract",
      --     highlight = "RenderMarkdownInfo",
      --     category = "obsidian",
      --   },
      --   summary = {
      --     raw = "[!SUMMARY]",
      --     rendered = "󰨸 Summary",
      --     highlight = "RenderMarkdownInfo",
      --     category = "obsidian",
      --   },
      --   tldr = {
      --     raw = "[!TLDR]",
      --     rendered = "󰨸 Tldr",
      --     highlight = "RenderMarkdownInfo",
      --     category = "obsidian",
      --   },
      --   info = {
      --     raw = "[!INFO]",
      --     rendered = "󰋽 Info",
      --     highlight = "RenderMarkdownInfo",
      --     category = "obsidian",
      --   },
      --   todo = {
      --     raw = "[!TODO]",
      --     rendered = "󰗡 Todo",
      --     highlight = "RenderMarkdownInfo",
      --     category = "obsidian",
      --   },
      --   hint = {
      --     raw = "[!HINT]",
      --     rendered = "󰌶 Hint",
      --     highlight = "RenderMarkdownSuccess",
      --     category = "obsidian",
      --   },
      --   success = {
      --     raw = "[!SUCCESS]",
      --     rendered = "󰄬 Success",
      --     highlight = "RenderMarkdownSuccess",
      --     category = "obsidian",
      --   },
      --   check = {
      --     raw = "[!CHECK]",
      --     rendered = "󰄬 Check",
      --     highlight = "RenderMarkdownSuccess",
      --     category = "obsidian",
      --   },
      --   done = {
      --     raw = "[!DONE]",
      --     rendered = "󰄬 Done",
      --     highlight = "RenderMarkdownSuccess",
      --     category = "obsidian",
      --   },
      --   question = {
      --     raw = "[!QUESTION]",
      --     rendered = "󰘥 Question",
      --     highlight = "RenderMarkdownWarn",
      --     category = "obsidian",
      --   },
      --   help = {
      --     raw = "[!HELP]",
      --     rendered = "󰘥 Help",
      --     highlight = "RenderMarkdownWarn",
      --     category = "obsidian",
      --   },
      --   faq = {
      --     raw = "[!FAQ]",
      --     rendered = "󰘥 Faq",
      --     highlight = "RenderMarkdownWarn",
      --     category = "obsidian",
      --   },
      --   attention = {
      --     raw = "[!ATTENTION]",
      --     rendered = "󰀪 Attention",
      --     highlight = "RenderMarkdownWarn",
      --     category = "obsidian",
      --   },
      --   failure = {
      --     raw = "[!FAILURE]",
      --     rendered = "󰅖 Failure",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   fail = {
      --     raw = "[!FAIL]",
      --     rendered = "󰅖 Fail",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   missing = {
      --     raw = "[!MISSING]",
      --     rendered = "󰅖 Missing",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   danger = {
      --     raw = "[!DANGER]",
      --     rendered = "󱐌 Danger",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   error = {
      --     raw = "[!ERROR]",
      --     rendered = "󱐌 Error",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   bug = {
      --     raw = "[!BUG]",
      --     rendered = "󰨰 Bug",
      --     highlight = "RenderMarkdownError",
      --     category = "obsidian",
      --   },
      --   example = {
      --     raw = "[!EXAMPLE]",
      --     rendered = "󰉹 Example",
      --     highlight = "RenderMarkdownHint",
      --     category = "obsidian",
      --   },
      --   quote = {
      --     raw = "[!QUOTE]",
      --     rendered = "󱆨 Quote",
      --     highlight = "RenderMarkdownQuote",
      --     category = "obsidian",
      --   },
      --   cite = {
      --     raw = "[!CITE]",
      --     rendered = "󱆨 Cite",
      --     highlight = "RenderMarkdownQuote",
      --     category = "obsidian",
      --   },
      -- },
      -- html = {
      --   -- Turn on / off all HTML rendering.
      --   enabled = true,
      --   -- Additional modes to render HTML.
      --   render_modes = false,
      --   comment = {
      --     -- Useful context to have when evaluating values.
      --     -- | text | text value of the comment node |
      --
      --     -- Turn on / off HTML comment concealing.
      --     conceal = true,
      --     -- Text to inline before the concealed comment.
      --     -- Output is evaluated depending on the type.
      --     -- | function | `value(context)` |
      --     -- | string   | `value`          |
      --     -- | nil      | nothing          |
      --     text = nil,
      --     -- Highlight for the inlined text.
      --     highlight = "RenderMarkdownHtmlComment",
      --   },
      --   -- HTML tags whose start and end will be hidden and icon shown.
      --   -- The key is matched against the tag name, value type below.
      --   -- | icon            | optional icon inlined at start of tag           |
      --   -- | highlight       | optional highlight for the icon                 |
      --   -- | scope_highlight | optional highlight for item associated with tag |
      --   tag = {},
      -- },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
}
