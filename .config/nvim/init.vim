" ============================================================================
" # PLUGINS
" =============================================================================
"set nocompatible
"filetype off
call plug#begin()

" VIM enhancements
Plug 'ciaranm/securemodelines'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'justinmk/vim-sneak'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'guns/xterm-color-table.vim'
"Plug 'andymass/vim-matchup'

" Fuzzy finder
"Plug 'airblade/vim-rooter'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

" Semantic language support
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
"Plug 'cespare/vim-toml'
"Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
"Plug 'rhysd/vim-clang-format'
"Plug 'fatih/vim-go'
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'

" Language Server
Plug 'neovim/nvim-lsp'

call plug#end()

" =============================================================================
" #  Netrw
" =============================================================================
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle = 3                                                                                                                                                                     
let g:netrw_preview   = 1                                                                                                                                                                     
let g:netrw_winsize   = 25
let g:netrw_altv = 1

" =============================================================================
" # 
" =============================================================================
function! FixIceberg() abort
  hi normal ctermbg=0
  hi link LspDiagnosticsError ErrorMsg
  hi LspDiagnosticsWarning ctermfg=242 ctermbg=233
endfunction

function! IfTerminalDoInsert()
  if &buftype ==# 'terminal'
    :startinsert!
  endif
endfunction

" =============================================================================
" # 
" =============================================================================
set noshowmode
set splitright

" Resize horizontal split
tnoremap <M-C-Up> <C-w>+
tnoremap <M-C-Down> <C-w>-
noremap <M-C-Up> <C-w>+
noremap <M-C-Down> <C-w>-
" Resize vertical split
tnoremap <M-C-Right> 2<C-w>>
tnoremap <M-C-Left> 2<C-w><
noremap <M-C-Right> 2<C-w>>
noremap <M-C-Left> 2<C-w><
" Exit terminal mode using double <Esc>
tnoremap <Esc><Esc> <C-\><C-n>
" Switch windows and start insert if buffer is a terminal
tnoremap <silent> <C-Up> <C-\><C-n><C-w>k:call IfTerminalDoInsert()<CR>
tnoremap <silent> <C-Down> <C-\><C-n><C-w>j:call IfTerminalDoInsert()<CR>
nnoremap <silent> <C-Up> <C-w>k:call IfTerminalDoInsert()<CR>
nnoremap <silent> <C-Down> <C-w>j:call IfTerminalDoInsert()<CR>
tnoremap <silent> <C-Left> <C-\><C-n><C-w>h:call IfTerminalDoInsert()<CR>
tnoremap <silent> <C-Right> <C-\><C-n><C-w>l:call IfTerminalDoInsert()<CR>
nnoremap <silent> <C-Left> <C-w>h:call IfTerminalDoInsert()<CR>
nnoremap <silent> <C-Right> <C-w>l:call IfTerminalDoInsert()<CR>

" Relative line numbers
set number
set rnu

let mapleader = ","
if executable('rls')
  lua require'nvim_lsp'.rls.setup{}
  "lua require'nvim_lsp'.rust_analyzer.setup{}

  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> <leader>s <cmd>vsplit +terminal<CR>i
  inoremap <silent> <leader>, <c-x><c-o>

  " Use LSP omni-completion in Rust files.
  autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

  " Auto-format *.rs files prior to saving them
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
endif

augroup IcebergColors
    autocmd!
    autocmd ColorScheme iceberg call FixIceberg()
augroup END
colorscheme nature
