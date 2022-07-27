require("workspaces").setup({
    hooks = {
        open = { "SessionsLoad .nvim/session", "NvimTreeToggle", "NvimTreeToggle" },
    },
})
