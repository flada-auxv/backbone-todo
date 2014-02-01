app = app || {}

do ->
  app.Todo = Backbone.Model.extend
    defaults:
      title: ''
      completed: false
    toggle: ->
      this.save
        completed: !this.get('completed')
