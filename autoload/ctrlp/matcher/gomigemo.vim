" File: autoload/ctrlp/matcher/gomigemo.vim
" Author: Tamaki Mizuha <mizyoukan@outlook.com>
" Last Modified: 24 February 2015
" License: NASL

function! s:matches(items, str) abort
  let l:items = deepcopy(a:items)

  for l:str in split(a:str)
    let l:re = gomigemo_matchers#pattern_vim(l:str)
    call filter(l:items, 'v:val =~ l:re')
  endfor

  return l:items
endfunction

function! ctrlp#matcher#gomigemo#match(items, str, limit, mmode, ispath, crfile, regex) abort
  if !executable('gmigemo')
    " Not supported.
    return a:items[:a:limit-1]
  endif

  if a:str =~ '^\s*$'
    return a:items[:a:limit-1]
  endif

  return s:matches(a:items, a:str)
endfunction
