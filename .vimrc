filetype plugin on
syntax on
set relativenumber
set number
set splitbelow splitright
set autoindent

let g:airline_theme='deus'
let mapleader = ";"

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
" General
command! Crun :exec "!echo not implemented"
command! Wrun :exec "!echo not implemented"
command! Arun :exec "!echo not implemented"

" Python -----------------------------------------------------------------------
autocmd FileType python let fill = 'pass'
autocmd FileType python command! Arun :exec 'w '.file_alias <bar> exec "!python ".file_alias <bar> exec "!rm ".file_alias
autocmd FileType python command! Wrun :w <bar> exec '!python '.file_
autocmd FileType python command! Crun :exec '!python '.file_
autocmd FileType python map <Leader>ar :Arun
autocmd FileType python map <Leader>wr :Wrun
autocmd FileType python map <Leader>pr :Crun
autocmd FileType python map <Leader>dba ipdb.set_trace()<Esc>
autocmd FileType python map <Leader>dbf /pdb.set_trace()<CR>
noremap <Leader>ds <Esc>o<Tab>"""<CR>"""<Up>

" LaTeX ------------------------------------------------------------------------
autocmd FileType tex command! Crun :exec '!pdflatex '.file_ <bar> exec '!okular '.file_name.'.pdf &'
autocmd FileType tex command! Wrun :exec '!pdflatex '.file_
autocmd FileType tex autocmd BufWritePost * TexUpdate
autocmd FileType tex noremap <Leader>u <Esc>:exec 'TexUpdate'<CR>

autocmd FileType tex inoremap <Leader>i \item 
autocmd FileType tex inoremap <Leader>sec \section{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap <Leader>ssec \subsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap <Leader>sssec \subsubsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex noremap <Leader>env i\begin{<++>}<CR><CR>\end{<++>}<Esc><S-v>2k:s/<++>/

" Markdown ----------------------------------------------------------------------
autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  set ft=markdown

autocmd FileType markdown command! Crun :exec "!pandoc -t latex -o ".file_name.".pdf ".file_

autocmd FileType markdown inoremap <Leader>i *
autocmd FileType markdown inoremap <Leader>n 1.
