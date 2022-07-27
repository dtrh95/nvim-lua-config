require("lualine").setup(
  {
    sections = {
      lualine_c = {
        {
          "filename",
          path = 2
        }
      },
      lualine_y = {
        {
          "diagnostics",
          sources = {"nvim_diagnostic"},
          symbols = {error = " ", warn = " ", info = " "}
        }
      }
    }
  }
)
