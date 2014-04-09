#!/usr/bin/env coffee

tasks = (grunt) ->

  gruntconf = {
    coffee:
      'gulpfile.js': 'gulpfile.coffee'
    watch:
      gulpfile:
        files: 'gulpfile.coffee'
        tasks: 'coffee'
  }

  # init
  grunt.initConfig gruntconf

  # LoadTasks
  pkgs = [
    'grunt-contrib-coffee'
    'grunt-contrib-watch'
  ]
  for pkg in pkgs
    grunt.loadNpmTasks pkg

  #  registerTask
  grunt.registerTask 'default', [
    'coffee'
  ]

module.exports = tasks