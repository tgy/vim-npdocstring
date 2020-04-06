if has('python3')
    command! -nargs=1 AvailablePython python3 <args>
    let s:available_short_python = ':py3'
elseif has('python')
    command! -nargs=1 AvailablePython python <args>
    let s:available_short_python = ':py'
else
    throw 'No python support present, vim-npdocstring will be disabled'
endif

command! Npdocstring exec("AvailablePython npdocstring_process_file()")

AvailablePython <<EOF
from __future__ import print_function

from sys import version_info

import npdocstring
import vim

try:
    import npdocstring
    npdocstring_imported = True
except ImportError:
    npdocstring_imported = False


def npdocstring_format_text_range(text_range):
    if not npdocstring_imported:
        print("No npdocstring python module detected, you should install it.")
        return

    old_text = '\n'.join(text_range)

    new_text = npdocstring.process_file(file_content=old_text)

    if new_text is None or old_text == new_text:
        return

    new_lines = new_text.split('\n')

    text_range[:] = new_lines

def npdocstring_file():
    npdocstring_format_text_range(vim.current.buffer)

def npdocstring_visual():
    npdocstring_format_text_range(vim.current.range)

EOF
