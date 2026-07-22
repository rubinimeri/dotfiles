return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            tsserver = { maxTsServerMemory = 8192 }, -- MB; try 8192, or 12288 on big monorepos
          },
        },
      },
    },
  },
}
