{ CompositeDisposable } = require 'atom'

module.exports = QuoteWords =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'quote-words:double': => @quoteWordsWith('"')
    @subscriptions.add atom.commands.add 'atom-workspace', 'quote-words:single': => @quoteWordsWith("'")

  deactivate: ->
    @subscriptions.dispose()

  quoteWordsWith: (quoteChar) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getLastSelection()
      replacement = selection.getText().replace(/(?:['"]?)(\w+)(?:['"]?)/g, quoteChar + '$1' + quoteChar)
      selection.insertText(replacement)
