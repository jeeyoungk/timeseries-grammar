module.exports = (grunt) ->
  # Project configuration.
  LIB_COMPILED =     'build/lib.js'
  PROJECT_COMPILED = 'build/pkg.js'
  PROJECT_FILES =    'src/**/*.coffee'
  PROJECT_MINIFIED = 'build/pkg.min.js'
  SPEC_FILES =       'spec/**/*.coffee'
  SPEC_COMPILED =    'build/spec.js'
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      main:
        src:  PROJECT_COMPILED
        dest: PROJECT_MINIFIED
    watch:
      main:
        files: [ PROJECT_FILES ]
        tasks: [ 'coffee', 'uglify' ]
        options: {}
    coffee:
      main:
        options:
          sourceMap: true
          join: true
        files: [
          src: [ PROJECT_FILES ], dest: PROJECT_COMPILED
        ]
      test:
        options:
          sourceMap: true
          join: true
        files: [
          src: [ SPEC_FILES ], dest: SPEC_COMPILED
        ]
    bower_concat:
      main:
        dest: LIB_COMPILED

  grunt.loadNpmTasks 'grunt-bower-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
