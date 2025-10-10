vim.g.mapleader = " "
--Swap C-g to act as C-c
--vim.keymap.set("v", "<C-g>", "<Esc>")
--vim.keymap.set("i", "<C-g>", "<Esc>")
--vim.keymap.set("n", "<C-g>", "<Esc>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("", "<leader>w", "<C-w>")

vim.keymap.set("", "<C-d>", "<C-d>zz")
vim.keymap.set("", "<C-u>", "<C-u>zz")
vim.keymap.set("", "n", "nzzzv")
vim.keymap.set("", "N", "Nzzzv")

vim.keymap.set("n", "<Space>y", '"+y')
vim.keymap.set("v", "<Space>y", '"+y')
vim.keymap.set("v", "<Space>Y", '"+Y')
vim.keymap.set("", "<Space>p", '\"_dP')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("i", "<C-c>", "<Esc>")
--For easier Emacs transition
vim.keymap.set("v", "<C-g>", "<Esc>")
vim.keymap.set("i", "<C-g>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", function ()
    vim.lsp.buf.format()
end)

--TODO: Learn quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--sed global replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
