" Only do this when not done yet for this buffer
if exists('g:loaded_npdocstring')
    finish
endif
let g:loaded_npdocstring = 1

if !exists("Npdocstring(...)")
    function Npdocstring(...)

        let npdocstring_cmd="npdocstring"

        if !executable(npdocstring_cmd)
            echoerr "File " . npdocstring_cmd . " not found. Please install it first."
            return
        endif

        let execmdline=npdocstring_cmd
		" save current cursor position
		let current_cursor = getpos(".")
        silent execute "0,$!" . execmdline
		" restore cursor
		call setpos('.', current_cursor)
        if v:shell_error != 0
            " Shell command failed, so open a new buffer with error text
            execute 'normal! gg"ayG'
            silent undo
            execute 'normal! ' . current_line . 'G'
            " restore cursor position
            call setpos('.', current_cursor)
            silent new
            silent put a
        end
    endfunction

    command! -nargs=? -bar Npdocstring call Npdocstring(<f-args>)
endif
