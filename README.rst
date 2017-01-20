========================
vim-npdocstring
========================

**ATTENTION:** you probably don't need this plugin! See `Why you may not need this plugin`_.

``vim-npdocstring`` is a Vim plugin that applies npdocstring to your current
file.

``npdocstring`` automatically generate missing Python docstrings, based on the
numpydoc style


Required
=====================

* `npdocstring <https://github.com/tgy/npdocstring>`_

``npdocstring`` cannote be installed with ``pip`` yet.

I'll take care of it soon.

Installation
=====================

Either use a plugin manager and add ``Plug[in] 'tgy/vim-npdocstring'`` to your
``vimrc``, or use pathogen.

Bindings
=====================

The plugin does not create any bindings by default, this is left up to the
user. An example could be:


::

 :nnoremap <leader>x :call Npdocstring()<cr>

or

::

 :nnoremap <leader>x :Npdocstring<cr>



Usage
=====================

call function

::

 :Npdocstring


Customization
=====================

No configuration. If you want to change something, open an issue.


Why you may not need this plugin
================================

The plugin itself is very simple. It handles user options granted, but at its
core it uses ex commands to perform its magic. ``npdocstring`` behaves like a
good unix command: it takes text on ``stdin`` and spits the altered result to
``stdout``, which is exactly what vim expects.

At its core, this plugin runs the ex command:

::

 0,$!npdocstring

This pipes the range ``0,$`` i.e. the whole file through a shell command
``npdocstring`` and replaces the range with the altered result.

Instead of installing this plugin, one could add a mapping e.g.:

::

 autocmd FileType python nnoremap <leader>y :0,$!npdocstring<Cr><C-o>

Alternatively npdocstring could be set as the ``formatprg`` for the python
filetype, and reformatting can be performed with the `gq{motion}`_ operator
(e.g. with visual selection) to reformat a part of the file. *On the other hand
this really flies in the face of what ``npdocstring`` is designed for, that is
an executable style guide for all Python code*.

.. _gq{motion}: https://github.com/vim/vim/blob/b182b40080a23ea1e1ffa28ea03b412174a236bb/runtime/doc/change.txt#L1299
