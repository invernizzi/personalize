set nocompatible          " vIMproved mode
set background=dark       " Assume a dark background
let g:tex_flavor= 'latex' " Load all tex files as latex


"-[ Vim Plug ]----------------------------------------------------------------------------
if has('nvim')
    let vim_path = '~/.nvim/'
else
    let vim_path = '~/.vim/'
endif

" Automatically load VimPlug, if not installed.
if empty(glob(vim_path . 'autoload/plug.vim'))
    execute '!mkdir -p ' . vim_path . 'autoload'
  redraw  " Avoids the 'press enter' prompt
  execute '! curl -fLo ' . vim_path . 'autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  redraw
endif
call plug#begin(vim_path . 'plugged')
let g:plug_timeout=300


"-[ Plugins ]-----------------------------------------------------------------------------

" Looks {
  Plug 'bling/vim-airline'      " Powerline look
  Plug 'bling/vim-bufferline'   " Show list of buffers in the command bar
  Plug 'kshenoy/vim-signature'  " Show bookmarks on the side
  Plug 'ryanoasis/vim-devicons' " Glyphs
  Plug 'flazz/vim-colorschemes'
" }

" General {
  Plug 'wesQ3/vim-windowswap'                             " Easy swap window position
  Plug 'terryma/vim-expand-region'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tacahiroy/ctrlp-funky'
  Plug 'jamessan/vim-gnupg'
  Plug 'christoomey/vim-tmux-navigator'                   " Seamless tmux/vim movements
  Plug 'bogado/file-line'                                 " Open at file:92
  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/vim-peekaboo'
" }

" Writing {
  Plug 'panozzaj/vim-autocorrect' " Autofix mistypes (e.g., teh => the)
  Plug 'reedes/vim-wordy'         " Similar to chrisper
  Plug 'tpope/vim-markdown'
  Plug 'lervag/vimtex'            " Latex. Ctrl-X Ctrl-O to autocomplete \cite
" }

" General Programming {
  Plug 'tpope/vim-surround'              " Change surrounding elements with one command
  Plug 'scrooloose/syntastic'            " Syntax
  Plug 'tpope/vim-fugitive'              " Git
  Plug 'vim-scripts/gitignore'           " Do not autcomplete
  Plug 'bronson/vim-trailing-whitespace' " :FixWhitespace
  Plug 'airblade/vim-gitgutter'          " Shows +- git signs on the side, ,hs to stage hunk
  Plug 'tpope/vim-commentary'            " Comment pressing gc
  Plug 'godlygeek/tabular'               " Tabularize command
  Plug 'Chiel92/vim-autoformat'          " Formatting code
  Plug 'jiangmiao/auto-pairs'            " Auto-close brackets
  Plug 'SirVer/ultisnips'                " Ultisnip core
  Plug 'honza/vim-snippets'                " Ultisnip snippets
  Plug 'chrisbra/csv.vim'
  Plug 'rking/ag.vim'
  if executable('ctags')
      Plug 'majutsushi/tagbar'           " Helpful tag bar on the side
  endif
" }

" Snippets & AutoComplete {
  Plug 'davidhalter/jedi-vim', {'for': 'python'}
  Plug 'ehamberg/vim-cute-python', {'for': 'python'}   " conceal python
  Plug 'fisadev/vim-isort', {'for': 'python'}  " sort python imports
" }

" Javascript {
  Plug 'elzr/vim-json', {'for': 'json'}
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'tyok/js-mask', {'for': 'javascript'}
" }

" HTML {
  Plug 'amirh/HTML-AutoCloseTag'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'gorodinskiy/vim-coloresque'  " Preview colors in HTML
  Plug 'tpope/vim-haml'
  Plug 'mattn/emmet-vim', {'for': 'html,css'}
  Plug 'Valloric/MatchTagAlways' " Highlight closing <html> tags
" }

" Ruby {
  Plug 'tpope/vim-rails', {'for': 'ruby'}
" }

" Puppet {
  Plug 'rodjek/vim-puppet'
  Plug 'robbevan/Vagrantfile.vim'
" }

" Go Lang {
  " Plug 'Blackrush/vim-gocode'
  " Plug 'fatih/vim-go'
" }


"-[ Vim Plug - Run Plugins ]--------------------------------------------------------------

filetype plugin indent on                   " required!
call plug#end()


"-[ Auto commands ]-----------------------------------------------------------------------


augroup writing
  autocmd!
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd filetype text,latex,markdown call AutoCorrect()
  autocmd filetype text,tex,latex,markdown set spell
augroup END

augroup linting
  autocmd!
  autocmd FileType puppet autocmd BufWritePost <buffer>  !puppet-lint <afile>
  autocmd FileType python,puppet,c,javascript,latex autocmd BufWritePre <buffer> FixWhitespace
augroup END

augroup formatting
  autocmd!
  autocmd FileType python setl expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END


"-[ Spelling ]----------------------------------------------------------------------------

" Do not consider capitalized words, and 's words as spelling errors
syn match myExCapitalWords +\<\w*[A-Z]\K*\>\|'s+ contains=@NoSpell

" underline spelling errors
hi clear SpellBad
hi SpellBad cterm=underline,bold

" Set custom spellfile
set spellfile=~/.vim.spellfile.en.utf-8.add


"-[ UI ]----------------------------------------------------------------------------------

silent! colorscheme mustang                        " Colorscheme, if available
set t_Co=256                                       " Enable 256 colors
syntax on                                          " Syntax highlighting
set mouse=a                                        " Automatically enable mouse usage
set mousehide                                      " Hide the mouse cursor while typing
set fillchars+=vert:\                              " Solid line for vsplit separator
set shortmess+=filmnrxoOtT                         " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash    " Better Unix / Windows compatibility
set virtualedit=onemore                            " Allow for cursor beyond last character
set history=1000                                   " Store a ton of history (default is 20)
set hidden                                         " Allow buffer switching without saving
set iskeyword-=.                                   " '.' is an end of word designator
set iskeyword-=#                                   " '#' is an end of word designator
set iskeyword-=-                                   " '-' is an end of word designator
set tabpagemax=15                                  " Only show 15 tabs
set showmode                                       " Display the current mode

set cursorline                                     " Highlight current line
highlight clear SignColumn                         " SignColumn should match background
highlight clear LineNr                             " Current line number row will have same background color in relative mode
                                                   " highlight clear CursorLineNr                                                " Remove highlight color from current line number
set ruler                                          " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd                                        " Show partial commands in status line and
set laststatus=2
set statusline=%<%f\                               " Filename
set statusline+=%w%h%m%r                           " Options
set statusline+=%{fugitive#statusline()}           " Git Hotness
set statusline+=\ [%{&ff}/%Y]                      " Filetype
set statusline+=\ [%{getcwd()}]                    " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%            " Right aligned file nav info
set backspace=indent,eol,start                     " Backspace for dummies
set linespace=0                                    " No extra spaces between rows
set showmatch                                      " Show matching brackets/parenthesis
set incsearch                                      " Find as you type search
set hlsearch                                       " Highlight search terms
set winminheight=0                                 " Windows can be 0 line high
set ignorecase                                     " Case insensitive search
set smartcase                                      " Case sensitive when uc present
set wildmenu                                       " Show list instead of just completing
set wildmode=list:longest,full                     " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]                      " Backspace and cursor keys wrap too
set scrolljump=5                                   " Lines to scroll when cursor leaves screen
set scrolloff=3                                    " Minimum lines to keep above and below cursor
set foldenable                                     " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.     " Highlight problematic whitespace
hi Normal ctermbg=none                             " Transparent terminal

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Always splits to the right and below
set splitright
set splitbelow

" Highlight the 80th column, if a line crosses it
if (exists ('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn cterm=bold
  "cterm=bold
endif

" Show absolute and relative numbers only in current window
augroup Numbers
  autocmd!
  autocmd WinEnter * setlocal number
  autocmd WinEnter * setlocal relativenumber
  autocmd WinLeave * setlocal nonumber
  autocmd WinLeave * setlocal norelativenumber
augroup END


" Markdown with fenced code blocks
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

" Set it to the first line when editing a git commit message
augroup git
  autocmd!
  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END


"-[ Functionality ]-----------------------------------------------------------------------

" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup restoreCursor
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

if !has('nvim')
    set ttymouse=xterm2  " Makes the mouse work in Tmux-vim
endif


"-[ Undo ]--------------------------------------------------------------------------------

set backup                  " Backups are nice ...
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload


"-[ Formatting ]--------------------------------------------------------------------------

let mapleader = '\'
map <space> \
set wrap                        " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set autoread                    " Set to auto read when a file is changed from the outside


"-[ Key bindings ]------------------------------------------------------------------------

" open file under cursor in a vertical split
:nnoremap gF :vertical wincmd f<CR>

" open a new file
nnoremap <Leader>o :CtrlP<cr>

" Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Wrapped lines goes down/up to next row, rather than next line in file.
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk




if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

"-[ Ultisnips ]----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"-[ Modeline ]----------------------------------------------------------------------------
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


"-[ Directories ]-------------------------------------------------------------------------
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()


" Vim tex sync
if executable('qpdfview')
  let g:vimtex_view_general_viewer = 'qpdfview'
  let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
  let g:vimtex_view_general_options_latexmk = '--unique'
endif

" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>


" Search word under cursor in files in the same directory
nmap <leader>* :Ag <c-r>=expand("<cword>")<cr><cr>

" Make concealed chars look normal
highlight Conceal ctermbg=none ctermfg=white
set conceallevel=2  " Activate conceal

" Press v repeatedly to select bigger text objects
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" CtrlP uses git or silver searcher
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Quick buffer selection
nnoremap <leader>b :ls<cr>:b
