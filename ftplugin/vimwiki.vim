function! vimwiki#follow_link() abort
  echo 'test'
endfunction

command! -buffer VimwikiSmartLink call vimwiki#follow_link()

nnoremap <silent><script><buffer> <Plug>VimwikiSmartLink :VimwikiSmartLink<CR>
nnoremap <CR><CR> <Plug>VimwikiSmartLink
