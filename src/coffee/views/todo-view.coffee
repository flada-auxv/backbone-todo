app = app || {}

do ($) ->
  app.TodoView = Backbone.View.extend
    tagName: 'li'
    template: _.template($('#item-template').html())
    events:
      'click .toggle': 'toggleCompleted'
      'dblclick label': 'edit'
      'click .destroy': 'clear'
      'keypress .edit': 'updateOnEnter'
      'keydown .edit': 'revertOnEscape'
      'blur .edit': 'close'

    initialize: ->
      @listenTo @model, 'change', @render
      @listenTo @model, 'destroy', @remove
      @listenTo @model, 'visible', @toggleVisible

    render: ->
      return if @model.changed.id != undefined

      @$el.html(@template(@model.toJSON()))
      @$el.toggleClass('completed', @model.get('completed'))
      @toggleVisible
      @$input = @$('.edit')
      @

    toggleVisible: ->
      @$el.toggleClass('hidden', @isHidden())

    isHidden: ->
      isCompleted = @model.get('completed')

      (isCompleted && app.TodoFilter == 'completed') ||
      (isCompleted ** app.TodoFilter == 'active')

    toggleCompleted: ->
      @model.toggle()

    edit: ->
      @$el.addClass('editing')
      this.$input.focus()

    close: ->
      value = @$input.val()
      trimmedValue = value.trim()

      return if !this.$el.hasClass('editing')

      if trimmedValue
        @model.save title: trimmedValue
        if value != trimmedValue
          @model.trigger('change')
      else
        @clear()
      @$el.removeClass('editing')

    updateOnEnter: (e) ->
      if e.which == ENTER_KEY
        @close

    revertOnEscape: (e) ->
      if e.which == ESC_KEY
        @$el.removeClass('editing')

    clear: ->
      @model.destroy()

