var app;

app = app || {};

(function() {
  return app.Todo = Backbone.Model.extend({
    defaults: {
      title: '',
      completed: false
    },
    toggle: function() {
      return this.save({
        completed: !this.get('completed')
      });
    }
  });
})();
