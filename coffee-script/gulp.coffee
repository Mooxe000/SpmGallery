#!/usr/bin/env coffee

echo = console.log
gutil = require 'gulp-util'
log = gutil.log

process = require '../_libs/process'
dir = require '../_libs/dir'

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
