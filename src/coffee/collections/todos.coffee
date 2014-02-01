app = app || {}

do ->
  Todos = Backbone.Collection.extend
    model: app.Todo
    localStorage: new Backbone.LocalStorage 'todos-backbone'
    completed: ->
      this.filter (todo) ->
        todo.get('completed')
    remaining: ->
      this.without.apply(this, this.completed())
    nextOrder: ->
      return 1 if !this.length

      this.last().get('order') + 1
    comparator: (todo) ->
      todo.get('order')

  app.todos = new Todos()
