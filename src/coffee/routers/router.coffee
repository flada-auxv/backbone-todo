app = app || {}

do ->
  TodoRouter = Backbone.Router.extend
    routes:
      '*filter': 'setFilter'

    setFilter: (param) ->
      app.TodoFilter = param || ''

      app.todos.trigger('filter')

  app.TodoRouter = new TodoRouter()
  Backbone.history.start()
