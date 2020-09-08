filetype plugin on
syntax on
set relativenumber
set number
set splitbelow splitright
set autoindent

let g:airline_theme='deus'
let mapleader = "`"

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set tabstop=8 softtabstop=- expandtab shiftwidth=4 smarttab

let file_ = expand('%:t')
let file_name = expand('%:t:r')
let file_ext = expand('%:e')
let file_alias = file_name . '_copy.' . file_ext 

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" All --------------------------------------------------------------------------
" Create and delete file alias for temporary running
command CreateAlias :exec '!cp '.file_ file_alias
"autocmd BufWinLeave :exec '!if [ -e '.file_alias.' ]; then rm '.file_alias.'; fi'
autocmd VimLeave :exec '!echo hahahah'
" Todo shortcuts
noremap <Leader>tt <Esc>/TODO<CR>
noremap <Leader>ip <Esc>/IN PROGRESS<CR>
noremap <Leader>tip <Esc>?TODO<CR>vwcIN PROGRESS<Esc>
noremap <Leader>td <Esc>?IN PROGRESS<CR>v2ecDONE<Esc>
" Switch tabs
nnoremap <Right> gt
nnoremap <Left> gT
" Error browsing
noremap <Leader>en <Esc>:lnext<CR>
noremap <Leader>ep <Esc>:lprevious<CR>
" Spell checking
noremap <Leader>o :setlocal spell! spelllang=en_us<CR>
" Fill methods
let fill = '<++>'
noremap <Leader>ff <Esc> :exec '/'.fill<CR>
noremap <Leader>fs <Esc> :exec '/'.fill <CR>v3lc
" Fuzzy file search
" -> :find [file] - find and jump to named file, * wildcard available 
" -> :b to search buffer for files you were on previously
set path+=**
set wildmenu
" Tags
" -> ^] to jump to tag under curson
" -> ^t to jump back up the tag stack 
command! MakeTags !ctags -R
" Autocomplete
" -> ^n to autocomplete based on allhttps://github.com/renatomatz/rice.git files
" -> ^x^f to autocomplete file names


" General ----------------------------------------------------------------------
let compiler = "echo "
let out_cmd = "echo "
let out_file = file_
command! Crun :exec "!".compiler.file_
command! Orun :exec "!".out_cmd.out_file
command! Wrun :w <bar> exec "Crun"
command! Arun :exec 'w '.file_alias <bar> exec "!".compiler." ".file_alias <bar> exec "!rm ".file_alias
command! Frun :exec "Wrun" <bar> exec "Orun"

map <Leader>pr :Crun
map <Leader>or :Orun
map <Leader>wr :Wrun
map <Leader>ar :Arun
map <Leader>fr :Frun

nnoremap <Leader>lc :lclose
nnoremap <Leader>ed /EDIT<CR>cw
inoremap <Leader>ed <Esc>/EDIT<CR>cw

let comment = "#"
inoremap <Leader>cc comment
" Python -----------------------------------------------------------------------
autocmd FileType python let fill = 'pass'
autocmd FileType python let compiler = 'python '
autocmd FileType python let out_cmd = 'python '

autocmd FileType python map <Leader>dba ipdb.set_trace()<Esc>
autocmd FileType python map <Leader>dbf /pdb.set_trace()<CR>
noremap <Leader>ds <Esc>o<Tab>"""<CR>"""<Up>

" C/C++ ------------------------------------------------------------------------
autocmd FileType c,cpp let compiler = "gcc "
autocmd FileType c,cpp command! Crun :exec "!".compiler."-g -o ".file_name." ".file_
autocmd FileType c,cpp command! Orun :exec "!./".file_name
autocmd FileType c,cpp command! Arun :Orun

" Go ---------------------------------------------------------------------------
autocmd FileType go let out_cmd = "./"
autocmd FileType go let out_file = expand('%:p:h:t')
autocmd FileType go let compiler = "go build"

autocmd FileType go command! Crun :exec "!".compiler
autocmd FileType go command! Orun :exec "!".out_cmd.out_file
autocmd FileType go command! Arun :Orun

" LaTeX ------------------------------------------------------------------------
autocmd FileType tex let compiler = 'pdflatex '
autocmd FileType tex let out_cmd = "okular "
autocmd FileType tex let out_file = file_name.".pdf &"

autocmd FileType tex autocmd BufWritePost * Wrun

autocmd FileType tex command Bib :exec "!bibtex ".file_name
autocmd FileType tex command Bibrun :exec "Bib" <bar> exec "Wrun"

autocmd FileType tex inoremap <Leader>i \item 
autocmd FileType tex inoremap <Leader>m $  $<Esc>hi
autocmd FileType tex inoremap <Leader>M \[  \]<Esc>hhi
autocmd FileType tex inoremap <Leader>( \left(  \right)<Esc>7hi
autocmd FileType tex inoremap <Leader>sec \section{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap <Leader>ssec \subsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap <Leader>sssec \subsubsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap <Leader>env \begin{<++>}<CR><CR>EDIT<CR><CR>\end{<++>}<Esc><S-v>4k:s/<++>/

" Markdown ----------------------------------------------------------------------
autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  set ft=markdown

autocmd FileType markdown let compiler = 'pandoc -t latex -o'
autocmd FileType markdown let out_cmd = "okular "
autocmd FileType markdown let out_file = file_name.".pdf &"

autocmd FileType markdown command! Crun :exec "!pandoc -t latex -o ".file_name.".pdf ".file_

autocmd FileType markdown inoremap <Leader>i *
autocmd FileType markdown inoremap <Leader>n 1.

" HTML --------------------------------------------------------------------------
autocmd FileType html let compiler = 'firefox'
autocmd FileType html command! Orun :Crun

autocmd FileType html inoremap <Leader>ee <><Left>
autocmd FileType html inoremap <Leader>el <++> EDIT </++><Esc><S-v>:s/++//g<Left><Left>
autocmd FileType html inoremap <Leader>eb <++>}<CR><CR>EDIT<CR><CR></++><Esc><S-v>4k:s/++//g<Left><Left>

autocmd FileType html let comment = "<!--   -->"

" Writing
autocmd FileType txt,tex,markdown nnoremap <S-w> f.
autocmd FileType txt,tex,markdown nnoremap <S-b> <S-f>.
