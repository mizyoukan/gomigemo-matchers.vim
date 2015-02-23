" File: autoload/unite/filters/matcher_gomigemo.vim
" Author: Tamaki Mizuha <mizyoukan@outlook.com>
" Last Modified: 15 Novemver 2014
" License: NASL

let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#matcher_gomigemo#define() abort
  if !executable('gmigemo')
    " Not supported.
    return {}
  endif

  return s:matcher
endfunction

let s:matcher = {
  \   'name': 'matcher_gomigemo',
  \   'description': 'gomigemo matcher'
  \ }

function! s:matcher.filter(candidates, context) abort
  if a:context.input =~ '^\s*$'
    return unite#filters#filter_matcher(a:candidates, '', a:context)
  endif

  let l:candidates = a:candidates

  for l:input in a:context.input_list
    if l:input =~ '^\s*$'
      continue
    elseif l:input =~ '^!'
      if l:input == '!'
        continue
      endif
      " Exclusion match.
      let l:pattern = g:gomigemo_matchers#pattern_vim(l:input[1:])
    elseif l:input =~ '^:'
      " Executes command.
      let a:context.execute_command = l:input[1:]
      continue
    else
      let l:pattern = g:gomigemo_matchers#pattern_vim(l:input)
    endif

    let l:candidates = unite#filters#filter_matcher(
      \ l:candidates, 'v:val.word =~ ' . string(l:pattern), a:context)
  endfor

  return l:candidates
endfunction

function! s:matcher.pattern(input) abort
  return g:gomigemo_matchers#pattern_vim(a:input)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
