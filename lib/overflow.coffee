OverflowEditorView = null
views = []

module.exports =
  config:
    usePreferredLineLength:
      type: 'boolean'
      default: true
      description: """Use the editor's preferred line length
                      (overrides the 'Column' setting below)"""
      order: 1
    column:
      type: 'integer'
      default: 80
      minimum: 0
      maximum: 500
      order: 2

  activate: ->
    @disposable = atom.workspace.observeTextEditors(@addViewToEditor)
    atom.config.observe 'overflow.usePreferredLineLength', (enabled) ->
      console.log 'overflow.usePreferredLineLength:', enabled
    atom.config.observe 'overflow.column', (column) ->
      console.log 'overflow.column:', column

  deactivate: ->
    @disposable.dispose()

    while view = views.shift()
      view.destroy()

  addViewToEditor: (editor) ->
    OverflowEditorView ?= require './overflow-editor-view'
    views.push new OverflowEditorView(editor)

