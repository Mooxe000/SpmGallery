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
  'jade'
  'markdown'
  'normalize-css'
  'respond'
]

modernizr = require './modernizr/gulp'
pure = require './pure/gulp'
fontawesome = require './font-awesome/gulp'
semanticui = require './semantic-ui/gulp'
jquery = require './jquery/gulp'
coffeescript = require './coffee-script/gulp'
less = require './less/gulp'
jade = require './jade/gulp'
markdown = require './markdown/gulp'
normalizecss = require './normalize-css/gulp'
respond = require './respond/gulp'
animatecss = require './animate-css/gulp'

gulp.task 'default', ->
  do modernizr.run
  do pure.run
  do fontawesome.run
  do semanticui.run
  do jquery.run
  do coffeescript.run
  do less.run
  do jade.run
  do markdown.run
  do normalizecss.run
  do respond.run
  do animatecss.run
