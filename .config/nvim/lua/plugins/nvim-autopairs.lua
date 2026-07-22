return {
  {

    "windwp/nvim-ts-autotag",
    disabled = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup({
        check_ts = true,
        enable_check_bracket_line = false,
      })

      -- Smart <Enter> between HTML tags
      npairs.add_rules({
        Rule(">", "</", "html")
          :use_regex(true)
          :with_pair(cond.none()) -- prevents auto-pairing typing
          :with_move(cond.none()) -- we only want <Enter> behavior
          :with_del(cond.none())
          :use_key("<CR>"),
      })
    end,
  },
}
