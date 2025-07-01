return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 60000, -- maximum wait time for a response, in milliseconds
          extra_request_body = {
            temperature = 0, -- controls randomness / creativity of the response
            max_completion_tokens = 8192, -- maximum number of tokens the model can generate in a response
            -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        -- ollama = {
        --   endpoint = "http://127.0.0.1:11434",
        --   timeout = 30000, -- Timeout in milliseconds
        --   extra_request_body = {
        --     options = {
        --       temperature = 0.75,
        --       num_ctx = 20480,
        --       keep_alive = "5m",
        --     },
        --   },
        -- },

        -- Custom providers
        -- groq = {
        --   __inherited_from = "openai",
        --   api_key_name = "GROQ_API_KEY",
        --   endpoint = "https://api.groq.com/openai/v1/",
        --   model = "llama-3.3-70b-versatile",
        --   disable_tools = true,
        --   extra_request_body = {
        --     temperature = 1,
        --     max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        --   },
        -- },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
