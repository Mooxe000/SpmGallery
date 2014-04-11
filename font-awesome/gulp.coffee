#!/usr/bin/env coffee

echo = console.log
gutil = require 'gulp-util'
log = gutil.log

process = require '../_libs/process'

exports.run = ->
  pkgpath = "#{__dirname}"
  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"
  distfiles = [
    "#{srcpath}/css"
    "#{srcpath}/fonts"
  ]

  process.checkdist distpath
  process.cleandist distpath
  process.dmproj distfiles, distpath
  process.pubproj pubpath