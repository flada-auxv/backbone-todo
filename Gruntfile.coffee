module.exports = (grunt) ->
  grunt.initConfig
    bower:
      install:
        options:
          targetDir: './lib'
          layout: 'byType'
          install: true
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: false
    haml:
      one:
        files:
          'index.html': 'src/index.haml'
    watch:
      files: ['src/*.haml']
      tasks: ['haml']

  grunt.loadNpmTasks('grunt-bower-task');
  grunt.loadNpmTasks('grunt-haml');
  grunt.loadNpmTasks('grunt-contrib-watch');
