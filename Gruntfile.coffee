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
    coffee:
      compile:
        expand: true
        cwd: 'src/coffee'
        src: ['*.coffee']
        dest: 'js/'
        ext: '.js'
    watch:
      haml:
        files: ['src/haml/*.haml']
        tasks: ['haml']
      coffee:
        files: ['src/coffee/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks('grunt-bower-task');
  grunt.loadNpmTasks('grunt-haml');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
