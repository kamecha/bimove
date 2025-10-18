
nnoremap <Plug>(bimove-enter) <Cmd>call bimove#mid(line('w0') - 1, line('w$') + 1)<CR>
nnoremap <Plug>(bimove) <Plug>(bimove-leave)
nnoremap <Plug>(bimove-leave) <Cmd>call bimove#cleanup()<CR>

nnoremap <Plug>(bimove-high) <Cmd>call bimove#move(v:false)<CR><Plug>(bimove)
nnoremap <Plug>(bimove-low) <Cmd>call bimove#move(v:true)<CR><Plug>(bimove)

