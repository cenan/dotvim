## Dictionary Completion

[Kaynak](http://vim.wikia.com/wiki/Dictionary_completions)

Dictionary CompletionEdit
Dictionary completion is one of many search facilities provided by Insert mode completion. It allows the user to get a list of keywords, based off of the current word at the cursor. This is useful if you are typing a long word (e.g. acknowledgeable) and don't want to finish typing or don't remember the spelling.

To start, we must first tell Vim where our dictionary is located. This is done via the 'dictionary' option. Below is an example. Your location may vary. See :help 'dictionary' for hints as to where you should look.

    :set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

Now, to use this list we have to enter insert mode completion. This is done by hitting CTRL-X while in insert mode. Next, you have to specify what you want to complete. For dictionaries use CTRL-K. Once in this mode the keys CTRL-N and CTRL-P will cycle through the matches. So, to complete the word "acknowledgeable" I would do the following in insert mode:

acknow<CTRL-X><CTRL-K><CTRL-N>
It can be cumbersome to type CTRL-X CTRL-K for many different completions. So, Vim gives us a shortcut. While in insert mode CTRL-N and CTRL-P will pull completion results from multiple sources. This set is defined by the 'complete' option and by default dictionary completion is not enabled. Add 'k' to the list to enable dictionary completion source:

:set complete+=k
Now, while in insert mode we can type the following to complete our example:

acknow<CTRL-N><CTRL-N>
This shortcut may not save a whole lot of typing. However, I find that it requires less hand movement to only worry myself with two key combinations, rather than four. However, it also means more results in your ins-completion list (rather than just other words in the buffer or whatever other options are set).

## Saving vim macros

Use `q` followed by a letter to record a macro. This just goes into one of the copy/paste registers so you can paste it as normal with the `"xp` or `"xP` commands in normal mode.

To save it you open up .vimrc and paste the contents, then the register will be around the next time you start vim.    
The format is something like:

    let @q = 'macro contents'

Be careful of quotes, though.  They would have to be escaped properly.

So to save a macro you can do:

- From normal mode: `qq`
- enter whatever commands
- From normal mode: `q`
- open .vimrc
- `"qp` to insert the macro into your `let @q = '...'` line
