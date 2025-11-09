
function! bimove#mid(high, low) abort
	" ウィンドウローカル変数を初期化（存在しなくても line() で代用）
	let w:high = a:high
	let w:low  = a:low
	let w:mid  = (w:low + w:high + 1) / 2

	if !exists('w:bimove_matchids')
		let w:bimove_matchids = []
	endif

	call bimove#deleteHighlight(w:bimove_matchids)

	call cursor(w:mid, 1)

	let w:bimove_matchids = bimove#highlight(w:high, w:mid, w:low)
endfunction

" w:high < w:mid <= w:low が常に成り立つようにする
function! bimove#move(isLower) abort
	" 範囲が狭まりきっていたら終了
	if w:high + 1 >= w:low
		return
	endif
	if a:isLower
		let w:high = w:mid
	else
		let w:low = w:mid
	endif

	call bimove#deleteHighlight(w:bimove_matchids)

	" 新しい mid を計算して移動
	let w:mid = (w:low + w:high + 1) / 2
	call cursor(w:mid, 1)

	let w:bimove_matchids = bimove#highlight(w:high, w:mid, w:low)
endfunction

function! bimove#highlight(high, mid, low) abort
	let matchids = []
	" 上半分
	eval matchids->add(matchadd('BimoveHigh', '\(\%' . a:high . 'l\|\%>' . a:high . 'l\)' . '\%<' . a:mid . 'l'))
	" カーソル行
	eval matchids->add(matchadd('BimoveCursor', '\%' . a:mid . 'l'))
	" 下半分
	eval matchids->add(matchadd('BimoveLow', '\%>' . a:mid . 'l' . '\(\%<' . a:low . 'l' . '\|' . '\%' . a:low . 'l\)'))
	return matchids
endfunction

function! bimove#deleteHighlight(matchids) abort
	" 途中でウィンドウ移動があると自動でマッチが消されるので、既に消されてたらそのままにする
	for id in a:matchids
		call matchdelete(id)
	endfor
endfunction

function! bimove#cleanup() abort
	call bimove#deleteHighlight(w:bimove_matchids)
	unlet w:bimove_matchids
	if exists('w:high')
		unlet w:high
	endif
	if exists('w:low')
		unlet w:low
	endif
	if exists('w:mid')
		unlet w:mid
	endif
endfunction
