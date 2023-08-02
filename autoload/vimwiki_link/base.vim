if exists('g:autoloaded_vimwiki_link')
  finish
endif
let g:autoloaded_vimwiki_link = 1

function! vimwiki_link#base#follow_link() abort
  let files = vimwiki_link#base#get_related_files()
  for idx in range(0, len(files) - 1)
    echo printf('%2d %s', idx+1, files[idx])
  endfor
  let idx = input('Select file by number: ')
  if idx !~# '\m[0-9]\+'
    return
  elseif idx > len(files) || idx <= 0
    echo "\n"
    echom 'index out of range.'
    return
  endif
  let selected = files[idx-1]
  let lnk = vimwiki#base#matchstr_at_cursor(vimwiki#vars#get_global('rxWord'))
  let sub = vimwiki#base#normalize_link_helper(
        \ selected,
        \ vimwiki#vars#get_global('rxWord'), lnk,
        \ vimwiki#vars#get_syntaxlocal('Link1'))
  let sub = vimwiki#base#apply_template(
        \ vimwiki#vars#get_syntaxlocal('WikiLink1Template2'),
        \ selected,
        \ lnk, '', '')
  call vimwiki#base#replacestr_at_cursor('\V'.lnk, sub)
endfunction

function! vimwiki_link#base#get_related_files(...) abort
  let size = a:0 ? a:0 : 10
  let input = expand('<cword>')
  let files = vimwiki#base#complete_file('', '', 0)
  let lst = files->map({_, v -> {'file': v, 'name': fnamemodify(v:val, ":t:r")}})
  let searched = lst->matchfuzzy(input, {'key': 'name'})
        \ ->map({_, v -> v['file']})
  return searched[:size]
endfunction
