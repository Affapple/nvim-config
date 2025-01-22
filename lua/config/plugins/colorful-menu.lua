return {
  "xzbdmw/colorful-menu.nvim",
  config = function()
    -- You don't need to set these options.
    require("colorful-menu").setup({
      ls = {
        lua_ls = {
          -- Maybe you want to dim arguments a bit.
          arguments_hl = "@comment",
        },
        ["typescript-language-server"] = {
          extra_info_hl = "@comment",
        },
        ts_ls = {
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          -- Such as (as Iterator), (use std::io).
          extra_info_hl = "@comment",
        },
        clangd = {
          -- Such as "From <stdio.h>".
          extra_info_hl = "@comment",
        },

        -- If true, try to highlight "not supported" languages.
        fallback = true,
      },
      fallback_highlight = "@variable",
      -- If provided, the plugin truncates the final displayed text to
      -- this width (measured in display cells). Any highlights that extend
      -- beyond the truncation point are ignored. Default 60.
      max_width = 60,
    })
  end,
}
