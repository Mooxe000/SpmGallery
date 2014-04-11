#!/usr/bin/env coffee

echo = console.log
gutil = require 'gulp-util'
log = gutil.log

dir = require '../_libs/dir'
process = require '../_libs/process'

exports.run = ->
  pkgpath = "#{__dirname}"
  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"
  distfiles = [ "#{srcpath}/extras/*" ]

  process.checkdist distpath
  process.cleandist distpath

  # build
  do ->
    dir.doindir srcpath, ->
      exec 'cake build:browser'

  process.dmproj distfiles, distpath
  process.pubproj pubpath
