return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    DEFAULT_OPTIONS = {
      names = false,
      custom_patterns = {
        "0x%x%x%x%x%x%x", -- Add a custom pattern for `0xrrggbb` colors
        "0x%x%x%x%x%x%x%x%x", -- Add a custom pattern for `0xrrggbbaa` colors
      },
    },
  },
}
