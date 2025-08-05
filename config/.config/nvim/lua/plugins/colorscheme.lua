return {
  {
    "catppuccin/nvim",
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = true, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
