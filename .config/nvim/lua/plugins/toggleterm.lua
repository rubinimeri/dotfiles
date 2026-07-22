return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = [[<C-\>]], -- or change to whatever you prefer
  },
  keys = {
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
  },
}
