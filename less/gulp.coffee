#!/usr/bin/env coffee

echo = console.log
gutil = require 'gulp-util'
log = gutil.log

process = require '../_libs/process'

exports.run = ->
  pkgpath = "#{__dirname}"
  version = '1.7.0'
  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"
  distfiles = [
    "#{srcpath}/dist/less-#{version}.js"
    "#{srcpath}/dist/less-#{version}.min.js"
  ]

  process.checkdist distpath
  process.cleandist distpath
  process.buildproj srcpath
  process.dmproj distfiles, distpath

  # rename
  do ->
    mv "#{distpath}/less-#{version}.js", "#{distpath}/less.js"
    mv "#{distpath}/less-#{version}.min.js", "#{distpath}/less.min.js"

  process.pubproj pubpath
