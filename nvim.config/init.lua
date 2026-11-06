-- Neovim config. Plugins are managed by the built-in vim.pack (nvim >= 0.12);
-- versions are pinned in nvim-pack-lock.json next to this file.
-- Update with :lua vim.pack.update() (or `updatevim` in fish).
--
-- Also loaded by the VSCode Neovim extension, which sets vim.g.vscode;
-- UI plugins and settings are skipped there.

local vscode = vim.g.vscode ~= nil
local map = vim.keymap.set

-- Leaders must be set before any plugin mappings are defined
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- easymotion reads these when it loads
vim.g.EasyMotion_do_mapping = 0 -- no default mappings
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_startofline = 0 -- keep cursor column on j/k motions

-- airline reads these when it loads
vim.g.airline_powerline_fonts = 1
vim.g["airline#extensions#whitespace#enabled"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#left_sep"] = " "
vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
vim.g.airline_left_sep = "\u{e0b0}"
vim.g.airline_left_alt_sep = "\u{e0b1}"
vim.g.airline_right_sep = "\u{e0b2}"
vim.g.airline_right_alt_sep = "\u{e0b3}"
vim.g.airline_symbols = {
    branch = "\u{e0a0}",
    readonly = "\u{e0a2}",
    linenr = " \u{e0a1}:",
    maxlinenr = "",
    colnr = " ℅:",
    crypt = "🔒",
    dirty = "⚡",
    paste = "∥",
    spell = "Ꞩ",
    notexists = "Ɇ",
    whitespace = "Ξ",
}

--- Plugins ------------------------------------------------------------------

local function gh(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    gh("preservim/nerdcommenter"),
    gh("haya14busa/is.vim"),
}, { confirm = false })

if vscode then
    vim.pack.add({
        { src = gh("asvetliakov/vim-easymotion"), name = "vsc-easymotion" },
    }, { confirm = false })
else
    vim.pack.add({
        gh("vim-airline/vim-airline"),
        gh("vim-airline/vim-airline-themes"),
        gh("tpope/vim-sleuth"),
        gh("tpope/vim-fugitive"),
        gh("crusoexia/vim-monokai"),
        gh("easymotion/vim-easymotion"),
    }, { confirm = false })
end

--- Options ------------------------------------------------------------------

local o = vim.opt

o.clipboard:append("unnamedplus")
o.whichwrap:append("<,>,h,l,[,]") -- cursor keys wrap across lines

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.copyindent = true

o.showmatch = true
o.swapfile = false
o.ignorecase = true
o.smartcase = true
o.wildmode = { "longest:full", "full" }

local group = vim.api.nvim_create_augroup("user_config", { clear = true })

-- Don't auto-wrap text or continue comments on new lines
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function()
        vim.opt_local.formatoptions:remove({ "t", "r", "o" })
    end,
})

--- Mappings -----------------------------------------------------------------

-- Very-magic search by default
map({ "n", "v" }, "/", "/\\v")

-- easymotion
map("", "<Leader>", "<Plug>(easymotion-prefix)")
map("", "<Leader>j", "<Plug>(easymotion-j)")
map("", "<Leader>k", "<Plug>(easymotion-k)")

-- First <Home> goes to the first non-blank, second to column 0
local function smart_home()
    local col = vim.fn.col(".")
    vim.cmd("normal! ^")
    if col == vim.fn.col(".") then
        vim.cmd("normal! 0")
    end
end
map({ "n", "i" }, "<Home>", smart_home, { silent = true })

if vscode then
    -- `s{char}{char}{label}`
    map("n", "s", "<Plug>(easymotion-f2)")
    return
end

--- Terminal-only settings -----------------------------------------------------

o.background = "dark"
vim.cmd.colorscheme("monokai")
o.mouse = "a"
o.number = true

-- easymotion across windows (not supported under VSCode)
map("n", "<Leader>L", "<Plug>(easymotion-overwin-line)")
map("n", "s", "<Plug>(easymotion-overwin-f2)")

-- F2 toggles line numbers
map({ "n", "v", "i" }, "<F2>", "<Cmd>set invnumber<CR>")

-- F6 converts tabs to spaces and strips trailing whitespace
map({ "n", "i" }, "<F6>", [[<Cmd>retab | %s/\s\+$//e<CR>]])

-- Hex editing: :Hexmode / F8 toggles the buffer through xxd
vim.api.nvim_create_user_command("Hexmode", function()
    if vim.b.editHex then
        vim.b.editHex = false
        vim.cmd("%!xxd -r")
    else
        vim.b.editHex = true
        vim.cmd("%!xxd")
    end
end, { bar = true })
map({ "n", "i" }, "<F8>", "<Cmd>Hexmode<CR>")

-- Buffers
map("n", "<Leader>T", "<Cmd>enew<CR>")
map("n", "<Leader>l", "<Cmd>bnext<CR>")
map("n", "<Leader>h", "<Cmd>bprevious<CR>")
map("n", "<Leader>bq", "<Cmd>bp | bd #<CR>") -- close buffer, keep window
map("n", "<Leader>bl", "<Cmd>ls<CR>")

-- Stop hitting F1 holy crap
map({ "n", "v", "i" }, "<F1>", "<Esc>")

-- Return to the last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.cmd("normal! zz")
        end
    end,
})
