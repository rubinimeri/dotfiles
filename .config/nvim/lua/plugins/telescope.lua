return {
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          media_files = {
            filetypes = { "png", "jpg", "jpeg", "webp", "svg" },
            find_cmd = "rg", -- or "fd"
            backend = "chafa", -- "viu" or "ueberzugpp" also valid
          },
        },
      })
      telescope.load_extension("media_files")
    end,
  },
}
