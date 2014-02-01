var app;

app = app || {};

(function() {
  var TodoRouter;
  TodoRouter = Backbone.Router.extend({
    routes: {
      '*filter': 'setFilter'
    },
    setFilter: function(param) {
      app.TodoFilter = param || '';
      return app.todos.trigger('filtter');
    }
  });
  app.TodoRouter = new TodoRouter();
  return Backbone.history.start();
})();
