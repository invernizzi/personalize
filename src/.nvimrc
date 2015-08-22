let g:python_host_prog='/usr/bin/python'
let g:LustTyJugglerSuppressRubyWarning = 1
if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
    set clipboard=unnamed
endif
source ~/.vimrc
