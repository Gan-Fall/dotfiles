-- fat cursor
vim.opt.guicursor = ""

-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line wrap
vim.opt.wrap = false

-- remove vim swapfile backups but keep undotree long list dir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- no highlight all items in search and enable incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- terminal colors
vim.opt.termguicolors = true

-- scrolloff maxes 8 lines toward the bottom unless at end of file
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update time
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
