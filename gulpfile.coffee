#!/usr/bin/env coffee

require 'shelljs/global'
gulp = require 'gulp'
gutil = require 'gulp-util'
log = gutil.log
argv = (require 'yargs').argv

pkglist = [
  'modernizr'
  'pure'
  'font-awesome'
  'semantic-ui'
  'jquery'
  'coffee-script'
  'less'
]

modernizr = require './modernizr/gulp'
pure = require './pure/gulp'
fontawesome = require './font-awesome/gulp'
semanticui = require './semantic-ui/gulp'
# jquery
# coffeescript
# less

gulp.task 'default', ->
  do modernizr.run
  do pure.run
  do fontawesome.run
  do semanticui.run
  # jquery
  # coffeescript
  # less
