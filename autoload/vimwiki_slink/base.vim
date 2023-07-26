function! vimwiki_slink#base#follow_link() abort
  let files = vimwiki_slink#base#get_related_files()
  for idx in range(0, len(files) - 1)
    echo printf('%2d %s %s', idx+1, files[idx][1], files[idx][0])
  endfor
  let idx = input('Select file: ')
  echo "\n" . files[idx-1][1]
endfunction

function! vimwiki_slink#base#get_related_files() abort
  let input = expand('<cword>')
  let files = vimwiki#base#complete_file('', '', 0)
  let mapped = map(files, {i, v -> [s:levenshtein_distance(input, v), v]})
  return sort(mapped, {i1, i2 -> i1[0] - i2[0]})[:10]
endfunction

function! s:levenshtein_distance(s1, s2) abort
  let m = len(a:s1) + 1
  let n = len(a:s2) + 1

  let d = range(0, n)
  let x = 0

  for i in range(1, m - 1)
    let old_x = d[0]
    let d[0] = i

    for j in range(1, n - 1)
      let cost = (strcharpart(a:s1, i - 1, 1) != strcharpart(a:s2, j - 1, 1))
      let min1 = d[j] + 1
      let min2 = d[j - 1] + 1
      let min3 = old_x + cost

      let x = d[j]
      let d[j] = min([min1, min2, min3])

      let old_x = x
    endfor
  endfor

  return d[n - 1]
endfunction
