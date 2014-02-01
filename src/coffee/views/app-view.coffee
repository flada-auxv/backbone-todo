app = app || {}

do ($) ->
  app.AppView = Backbone.View.extend
    el: '#todoapp'
    statsTemplate: _.template($('#stats-template').html())
    events:
      'keypress #new-todo': 'createOnEnter',
      'click #clear-completed': 'clearCompleted',
      'click #toggle-all': 'toggleAllComplete'

    initialize: ->
      @allCheckbox = @$('#toggle-all')[0]
      @$input = @$('#new-todo')
      @$footer = @$('#footer')
      @$main = @$('#main')
      @$list = @$('#todo-list')

      @listenTo app.todos, 'add', @addOne
      @listenTo app.todos, 'reset', @addAll
      @listenTo app.todos, 'change:completed', @filterOne
      @listenTo app.todos, 'filter', @filterAll
      @listenTo app.todos, 'all', @render

      app.todos.fetch reset: true

    render: ->
      completed = app.todos.completed().length
      remaining = app.todos.remaining.length

      if app.todos.length
        @$main.show
        @$footer.show

        @$footer.html @statsTemplate
          completed: completed
          remaining: remaining

        @$('#filters li a')
          .removeClass 'selected'
          .filter '[href="#/' + (app.TodoFilter || '') + '"]'
          .addClass 'selected'
      else
        @$main.hide()
        @$footer.hide()

      @allCheckbox.checked = !remaining

    addOne: (todo) ->
      view = new app.TodoView(model: todo)
      @$list.append view.render().el

    addAll: ->
      @$list.html ''
      app.todos.each @addOne, this

    filterOne: (todo) ->
      todo.trigger 'visible'

    filterAll: ->
      app.todos.each @filterOne, this

    newAttributes: ->
      # return
      title: @$input.val().trim()
      order: app.todos.nextOrder()
      completed: false

    createOnEnter: (e) ->
      if e.which == ENTER_KEY && @$input.val().trim()
        app.todos.create @newAttributes()
        @$input.val ''

    createCompleted: ->
      _.invoke(app.todos.completed, 'destroy')
      false

    toggleAllComplete: ->
      completed = @allCheckbox.checked

      app.todos.each (todo) ->
        todo.save
          completed: completed
