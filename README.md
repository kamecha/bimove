# bimove
Moves the cursor using a binary search approach.

**Alpha version. Any changes, including backward incompatible ones, are applied without announcements.**

![bimove-code](https://github.com/user-attachments/assets/f59f8742-c692-47e2-b8cc-fbedab5aae19)

## usage

```vim
nnoremap M <Plug>(bimove-enter)<Plug>(bimove)

nnoremap <Plug>(bimove)H <Plug>(bimove-high)<Plug>(bimove)
nnoremap <Plug>(bimove)L <Plug>(bimove-low)<Plug>(bimove)

highlight link BimoveHigh Search
highlight link BimoveCursor Visual
highlight link BimoveLow Visual
```
