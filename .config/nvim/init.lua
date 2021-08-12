local cmd = vim.cmd
local g = vim.g
local o = vim.o
local wo = vim.wo

-- set leader key to <Space>
-- leader key is used to many commands in
-- this configuration
g.mapleader = ' '
g.auto_save = 0

cmd 'syntax enable'
cmd 'syntax on'
cmd 'filetype plugin on'

cmd 'autocmd BufWritePost plugins.lua PackerCompile'

cmd 'set mouse=a'
cmd 'set shiftwidth=2'
cmd 'set backspace=indent,eol,start'
cmd 'set encoding=UTF-8'
cmd 'set noshowmode'
cmd 'set foldcolumn=0'
cmd 'set showtabline=1'

-- setup merlin and ocaml
cmd [[
  if executable('opam')
    let g:opamshare=substitute(system('opam config var share'),'\n$','','''')
    if isdirectory(g:opamshare."/merlin/vim")
      execute "set rtp+=" . g:opamshare."/merlin/vim"
    endif
  endif
]]

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

wo.number = true
wo.relativenumber = true
wo.wrap = false

o.smarttab = true
o.expandtab = true

o.foldcolumn = '0'
o.termguicolors = true

o.tabstop=2

g.indentLine_enabled = 1
g.indentLine_char = '▏'
g.indent_blankline_char = "▏"
g.indent_blankline_indent_level = 15

require 'plugins.plugins'
require 'plugins.completion'
require 'plugins.theme'
require 'plugins.code-actions'
require 'plugins.languages'
require 'plugins.tree'
require 'plugins.keymaps'
require 'plugins.tabs'
require 'plugins.statusline'
require 'plugins.git'
require 'plugins.format'
require 'plugins.debugger'
require 'plugins.toggleterm'
require 'plugins.commands'

vim.fn['glaive#Install']()

require('neoscroll').setup()
require('telescope').load_extension('media_files')
require('nvim-web-devicons').setup {}
require('symbols-outline').setup {
  highlight_hovered_item = true,
  show_guides = true,
}

cmd 'hi NonText guifg=bg'

-- decrease buffer border width
cmd 'set fillchars+=vert:\\▕'
cmd 'hi vertsplit guifg=fg guibg=bg'

-- fix relative numbers
cmd 'au TermOpen * setlocal nonumber norelativenumber'

cmd 'autocmd BufNewFile,BufRead .babelrc set filetype=json'
cmd 'autocmd BufNewFile,BufRead .eslintrc set filetype=javascript'
cmd 'autocmd BufNewFile,BufRead .prettierrc set filetype=json'

cmd [[
  autocmd BufWinEnter,WinEnter,TermOpen term://* setlocal norelativenumber
  autocmd BufWinEnter,WinEnter,TermOpen term://* setlocal nonumber
  autocmd BufWinEnter,WinEnter,TermOpen term://* setlocal signcolumn=no
]]
