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
  distfiles = [ "#{srcpath}/build/packaged/*" ]

  process.default srcpath, distpath, distfiles, pubpath