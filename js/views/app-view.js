var app;

app = app || {};

(function($) {
  return app.AppView = Backbone.View.extend({
    el: '#todoapp',
    statsTemplate: _.template($('#stats-template').html()),
    events: {
      'keypress #new-todo': 'createOnEnter',
      'click #clear-completed': 'clearCompleted',
      'click #toggle-all': 'toggleAllComplete'
    },
    initialize: function() {
      this.allCheckbox = this.$('#toggle-all')[0];
      this.$input = this.$('#new-todo');
      this.$footer = this.$('#footer');
      this.$main = this.$('#main');
      this.$list = this.$('#todo-list');
      this.listenTo(app.todos, 'add', this.addOne);
      this.listenTo(app.todos, 'reset', this.addAll);
      this.listenTo(app.todos, 'change:completed', this.filterOne);
      this.listenTo(app.todos, 'filter', this.filterAll);
      this.listenTo(app.todos, 'all', this.render);
      return app.todos.fetch({
        reset: true
      });
    },
    render: function() {
      var completed, remaining;
      completed = app.todos.completed().length;
      remaining = app.todos.remaining().length;
      if (app.todos.length) {
        this.$main.show();
        this.$footer.show();
        this.$footer.html(this.statsTemplate({
          completed: completed,
          remaining: remaining
        }));
        this.$('#filters li a').removeClass('selected').filter('[href="#/' + (app.TodoFilter || '') + '"]').addClass('selected');
      } else {
        this.$main.hide();
        this.$footer.hide();
      }
      return this.allCheckbox.checked = !remaining;
    },
    addOne: function(todo) {
      var view;
      view = new app.TodoView({
        model: todo
      });
      return this.$list.append(view.render().el);
    },
    addAll: function() {
      this.$list.html('');
      return app.todos.each(this.addOne, this);
    },
    filterOne: function(todo) {
      return todo.trigger('visible');
    },
    filterAll: function() {
      return app.todos.each(this.filterOne, this);
    },
    newAttributes: function() {
      return {
        title: this.$input.val().trim(),
        order: app.todos.nextOrder(),
        completed: false
      };
    },
    createOnEnter: function(e) {
      if (e.which === ENTER_KEY && this.$input.val().trim()) {
        app.todos.create(this.newAttributes());
        return this.$input.val('');
      }
    },
    clearCompleted: function() {
      _.invoke(app.todos.completed(), 'destroy');
      return false;
    },
    toggleAllComplete: function() {
      var completed;
      completed = this.allCheckbox.checked;
      return app.todos.each(function(todo) {
        return todo.save({
          completed: completed
        });
      });
    }
  });
})($);
