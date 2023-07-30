" check vimwiki plugin is loaded
if !exists('g:loaded_vimwiki')
  finish
endif

command! -buffer VimwikiSmartLink call vimwiki_slink#base#follow_link()

nnoremap <silent><script><buffer> <Plug>VimwikiSmartLink :VimwikiSmartLink<CR>
nnoremap <CR><CR> <Plug>VimwikiSmartLink
