return {
  -- Disable LazyVim's default mini.surround entirely
  {
    "nvim-mini/mini.surround",
    enabled = false,
  },

  -- Install and activate nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("nvim-surround").setup({
        -- Explicitly set keymaps to avoid any LazyVim interference
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      })
    end,
  },
}
