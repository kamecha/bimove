
function! bimove#mid(high, low) abort
	" ウィンドウローカル変数を初期化（存在しなくても line() で代用）
	let w:high = a:high
	let w:low  = a:low
	let w:mid  = (w:low + w:high + 1) / 2

	if !exists('w:bimove_matchids')
		let w:bimove_matchids = []
	endif

	call bimove#deleteHighlight()

	call cursor(w:mid, 1)

	call bimove#highlight(w:high, w:mid, w:low)
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

	call bimove#deleteHighlight()

	" 新しい mid を計算して移動
	let w:mid = (w:low + w:high + 1) / 2
	call cursor(w:mid, 1)

	call bimove#highlight(w:high, w:mid, w:low)
endfunction

function! bimove#highlight(high, mid, low) abort
	" 上半分
	eval w:bimove_matchids->add(matchadd('BimoveHigh', '\(\%' . w:high . 'l\|\%>' . w:high . 'l\)' . '\%<' . w:mid . 'l'))
	" 下半分
	eval w:bimove_matchids->add(matchadd('BimoveLow', '\(\%' . w:mid . 'l' . '\|' . '\%>' . w:mid . 'l\)' . '\(\%<' . w:low . 'l' . '\|' . '\%' . w:low . 'l\)'))
endfunction

function! bimove#deleteHighlight() abort
	" 途中でウィンドウ移動があると自動でマッチが消されるので、既に消されてたらそのままにする
	if exists('w:bimove_matchids')
		for id in w:bimove_matchids
			call matchdelete(id)
		endfor
	endif
	let w:bimove_matchids = []
endfunction

function! bimove#cleanup() abort
	call bimove#deleteHighlight()
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
