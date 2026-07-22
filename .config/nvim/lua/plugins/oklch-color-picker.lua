return {
  {
    "nvim-mini/mini.hipatterns",
    enabled = false,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      highlight = {
        style = "virtual_left",
        enabled_lsps = true,
      },
    },
  },
}
