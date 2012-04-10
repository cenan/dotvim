function! Fixturkish()
	:s/ç/\\c{c}/ge
	:s/Ç/\\c{C}/ge
	:s/ş/\\c{s}/ge
	:s/Ş/\\c{S}/ge
	:s/ı/{\\i}/ge
	:s/İ/\\.{I}/ge
	:s/ü/\\"{u}/ge
	:s/Ü/\\"{U}/ge
	:s/ö/\\"{o}/ge
	:s/Ö/\\"{O}/ge
	:s/ğ/\\u{g}/ge
	:s/Ğ/\\u{G}/ge
endfunction
