" See `:h defaults.vim`
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Plugins
"" vim-plug : https://github.com/junegunn/vim-plug
"" Specify a directory for plugins
"" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Color Schema
Plug 'sainnhe/edge'

Plug 'bronson/vim-trailing-whitespace'

" コメントON/OFFを手軽に実行
Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'

" ', " 等の入れ替え
Plug 'tpope/vim-surround'
" (), [], {} 等の自動補完
Plug 'cohama/lexima.vim'

" for status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File Search by fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Rails
Plug 'tpope/vim-rails'
"" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'

" for Golang
"" Golangを本格的に使うようになったらいれる
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }

" for Lint
Plug 'dense-analysis/ale'

" indent visualization
Plug 'yggdroot/indentline'

" LSP (Langage Server Protcol)
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Snippets
"" integration to lsp
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" for Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'
Plug 'mattn/vim-maketable'

" Plug 'andrewradev/switch.vim'

" Git
Plug 'tpope/vim-fugitive'
"" 変更した行を強調
Plug 'airblade/vim-gitgutter'

" ファイルの自動保存(保存をフックに何かやる処理を入れてないので)
Plug '907th/vim-auto-save'

" File Viewer
Plug 'lambdalisue/fern.vim'
"" for file icons
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" open URL on browser
Plug 'tyru/open-browser.vim'

" A collection of language packs for Vim.
"" 他pluginとの干渉を避けるためなるべく最後にする
Plug 'sheerun/vim-polyglot'
call plug#end()

"################################################

filetype plugin indent on

" Visual setteings
syntax enable
set number
set ruler
set title
set showmatch
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
" allows moving the buffer without saving
set hidden

augroup vimrc
  au!
  " md as markdown, instead of modula2
  au BufNewFile,BufRead *.{md} set filetype=markdown
  au BufWritePost  ~/.vimrc  source ~/.vimrc
augroup END

" for Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
" preview open with FireFox (plugin previm)
let g:previm_open_cmd = 'open -a Firefox'

"" Linter
let g:ale_fixers = {
\  'ruby': ['rubocop'],
\}
let g:ale_sign_column_always = 1 " 左端にsymbol用のcolumnを表示させておく
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
set updatetime=500 " Linterのチェックの反映を 0.5秒にする
" let g:ale_fix_on_save = 1 " 保存時にauto correctを実行
let g:ale_lint_on_enter = 1 " ファイルを開いたときにlint実行
let g:ale_lint_on_save = 1 " ファイルを保存したときにlint実行
let g:ale_lint_on_text_changed = 'never' " 編集中のlintはしない

"" LSPと合わせると突然vimが落ちたり、挙動が怪しいのでRubyのsyntaxはLSP(solargraph)に任せる
let g:polyglot_disabled = ['ruby']

" vim-auto-save
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
"" git commitの編集ではauto_saveをoffにする
augroup ignore_ft_gitcommit
  au!
  au FileType gitcommit let b:auto_save = 0
augroup END

" Snippets
""" vim-vsnip mapping.
imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand)' : '<C-j>'

" color scheme
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"" for dark version
set background=dark
"" the configuration options should be placed before `colorscheme edge`
let g:edge_style = 'aura'
let g:edge_disable_italic_comment = 1
colorscheme edge

"" Directories for swp files
set nobackup
set noswapfile

" Search settings in file
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Map leader to ,
let mapleader = "\<Space>"

" Key mappings
noremap YY "+y<CR>
noremap PP "+p<CR>
"" Buffer nav
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
"" Close buffer
nnoremap <leader>c :bd<CR>
"" Save file
nnoremap <leader>w :w<CR>
"" Clean search (highlight)
nnoremap <leader><leader> :noh<CR>
"" Toggle line number
nnoremap <leader>n :set number!<CR>

" Fern (for File Viewer)
""" Project drawer
nnoremap <C-d> :Fern . -drawer -toggle<CR>
""" open current directory
nnoremap <C-c> :Fern %:h -opener=vsplit<CR>
"" for file icon
let g:fern#renderer = "nerdfont"

" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>x :Commands<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>gf :GFiles<CR>
nnoremap <Leader>a :Ag<CR>

" Git
"" fugitive
"" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

nnoremap <leader>gs :tab sp<CR>:Gstatus<CR>:only<CR>
nnoremap <leader>gg :Ggrep 
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gp :Git push<CR>

" Use gh(github CLI) command
nnoremap <leader>ghpr :!gh pr create --fill --web<CR>
nnoremap <leader>ghck :!gh pr checkout <pr-number>
nnoremap <leader>ghs :!gh pr status<CR>
nnoremap <leader>ghl :!gh pr list --assignee <user-id>

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" LSP settings
"" ale と競合するため off
let g:lsp_diagnostics_enabled = 0
"" debug for lsp
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

if executable('solargraph')
    " require solargraph gem
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif
" 定義元へのジャンプ
nnoremap <C-]> :LspDefinition<CR>
nnoremap <C-h> :LspHover<CR>
nnoremap <C-r> :LspReferences<CR>

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" vim-airline
let g:airline_theme = 'night_owl'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" for ale
let g:airline#extensions#ale#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#branch#prefix     = '➔' ", ➥
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline_symbols.linenr     = '␊'
let g:airline_symbols.branch     = '⎇'
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.paste      = 'Þ'
let g:airline_symbols.paste      = '∥'
let g:airline_symbols.whitespace = '_'
