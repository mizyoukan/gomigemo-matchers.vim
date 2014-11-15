" File: autoload/gomigemo_matchers.vim
" Author: Tamaki Mizuha <mizyoukan@outlook.com>
" Last Modified: 15 Novemver 2014
" License: NASL

let s:save_cpo = &cpo
set cpo&vim

let s:P = vital#of('gomigemo_matchers').import('ProcessManager')

function! g:gomigemo_matchers#pattern(str)
  let s:p = s:P.of('migemo', 'gmigemo')
  if s:p.is_new()
    call s:p.reserve_wait(['QUERY: '])
  endif

  call s:p.reserve_writeln(iconv(a:str, &encoding, 'utf-8'))
  call s:p.reserve_read(['QUERY: '])

  while 1
    let l:result = s:p.go_bulk()
    sleep 1m
    if l:result.done
      break
    elseif l:result.fail
      call s:p.shutdown()
      return g:gomigemo_matchers#pattern(a:str)
    endif
  endwhile

  return iconv(substitute(substitute(l:result.out, '^PATTERN: ', '', ''),
    \ '\n$', '', ''),
    \ 'utf-8', &encoding)
endfunction

function! g:gomigemo_matchers#pattern_vim(str)
  let l:re = g:gomigemo_matchers#pattern(a:str)
  " Go regexp pattern -> Vim regexp pattern
  let l:re = substitute(l:re, '(?:', '(', 'g')
  let l:re = substitute(l:re, '[\(\)\|]', '\\\0', 'g')
  return l:re
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
