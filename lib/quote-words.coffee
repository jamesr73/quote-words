{ CompositeDisposable } = require 'atom'

module.exports = QuoteWords =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'quote-words:double': => @quoteSelectionWith('"')
    @subscriptions.add atom.commands.add 'atom-workspace', 'quote-words:single': => @quoteSelectionWith("'")

  deactivate: ->
    @subscriptions.dispose()

  quoteSelectionWith: (quoteChar) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getLastSelection()
      replacement = @quote(selection.getText(), quoteChar)
      selection.insertText(replacement)

  quote: (text, quoteChar) ->
    text.replace(/(?:['"]?)(\w+)(?:['"]?)/g, quoteChar + '$1' + quoteChar)
