# gomigemo-matchers.vim: Go/Migemo matchers for Vim

[Go/Migemo][gomigemo] matcher for [Unite.vim] or [ctrlp.vim]

## Requirement

- [vimproc.vim]
- gmigemo: `go get -u github.com/koron/gomigemo/cmd/gmigemo`


## Usage

for Unite.vim:

    call unite#custom#source('file', 'matchers', 'matcher_gomigemo')


for ctrlp.vim:

    let g:ctrlp_match_func = {'match': 'g:ctrlp#matcher#gomigemo#match'}


## License

NASL License


[unite.vim]:https://github.com/Shougo/unite.vim
[ctrlp.vim]:https://github.com/ctrlpvim/ctrlp.vim
[vimproc.vim]:https://github.com/Shougo/vimproc.vim
[gomigemo]:https://github.com/koron/gomigemo
