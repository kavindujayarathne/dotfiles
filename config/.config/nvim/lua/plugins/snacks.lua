return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
           ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        -- sections
        sections = {
          { section = "header", padding = 2 },
          -- { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 2 },
          { section = "keys", indent = 2, padding = 2 },
          {
            section = "terminal",
            icon = " ",
            title = "Git Status",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            padding = 2,
            ttl = 5 * 60,
            indent = 2,
          },
          { section = "startup" },
        },
        -- sections = {
        --   { section = "header" },
        --   { section = "keys", gap = 1, padding = 1 },
        --   { section = "startup", padding = 1 },
        --   {
        --     section = "terminal",
        --     pane = 2,
        --     icon = " ",
        --     title = "Git Status",
        --     enabled = function()
        --       return Snacks.git.get_root() ~= nil
        --     end,
        --     cmd = "git status --short --branch --renames",
        --     -- height = 10,
        --     padding = 1,
        --     ttl = 5 * 60,
        --     indent = 2,
        --   },
        --   {
        --     section = "terminal",
        --     pane = 2,
        --     icon = " ",
        --     title = "Git diff",
        --     enabled = function()
        --       return Snacks.git.get_root() ~= nil
        --     end,
        --     cmd = "git --no-pager diff --stat -B -M -C",
        --     -- cmd = "git log -5 --oneline",
        --     -- height = 10,
        --     padding = 1,
        --     ttl = 5 * 60,
        --     indent = 2,
        --   },
        -- },
      },
      -- other options
    },
  },
}
