set nohls
set incsearch
set nowrap
set rnu
set nu
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nobackup
exec 'set undodir=' . stdpath('data') . '/undodir'
set undofile
set scrolloff=8
set cmdheight=1
set updatetime=50
set shortmess+=c
set signcolumn=yes

set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*

set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set listchars=tab:▸\ ,trail:·
set list

let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'is0n/fm-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'mbbill/undotree'

Plug 'airblade/vim-rooter'
Plug 'cljoly/telescope-repo.nvim'

Plug 'sbdchd/neoformat'

Plug 'Mofiqul/dracula.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/lsp-colors.nvim'
call plug#end()

let mapleader = " "

nnoremap <silent> Q <nop>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap n nzzzv
nnoremap N Nzzzv
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>lf :Lf<CR>
nnoremap <leader>lg :Lazygit<CR>

" LSP
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <leader>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <leader>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

" Telescope
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require'telescope.builtin'.find_files()<CR>
nnoremap <leader>pw :lua require'telescope.builtin'.grep_string()<CR>
nnoremap <leader>pb :lua require'telescope.builtin'.buffers()<CR>
nnoremap <leader>fh :lua require'telescope.builtin'.help_tags()<CR>
exec 'nnoremap <leader>fj :lua require"telescope".extensions.repo.list{fd_opts="--ignore-file=' . stdpath("config") . '/fdignore"}<CR>'
nnoremap <leader>gc :lua require'telescope.builtin'.git_commits()<CR>
nnoremap <leader>gs :lua require'telescope.builtin'.git_status()<CR>
nnoremap <leader>gbc :lua require'telescope.builtin'.git_bcommits()<CR>
nnoremap <leader>gh :lua require'telescope.builtin'.git_branches()<CR>

" QF
nnoremap <C-k> :cprev<CR>zz
nnoremap <C-j> :cnext<CR>zz
nnoremap <leader>k :lprev<CR>zz
nnoremap <leader>j :lnext<CR>zz
nnoremap <C-q> :call ToggleQFList()<CR>
nnoremap <leader>q :call ToggleLocList()<CR>

fun! ToggleQFList()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfun

fun! ToggleLocList()
    if empty(filter(getwininfo(), 'v:val.loclist'))
        lopen
    else
        lclose
    endif
endfun

colorscheme dracula
hi SignColumn guibg=None
hi Normal guibg=None
hi TelescopeNormal guibg=None

lua require'colorizer'.setup()

lua require'l.lsp'
lua require'l.treesitter'
lua require'l.comp'
lua require'l.fm-nvim'
lua require'l.telescope'

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
