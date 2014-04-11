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

  distfiles = [
    "#{srcpath}/jade.js"
    "#{srcpath}/runtime.js"
  ]

  process.checkdist distpath
  process.cleandist distpath

  # build
  do ->
    dir.doindir srcpath, ->
      # check npm support
      unless test '-e', "#{srcpath}/node_modules"
        exec 'npm install'
      exec 'npm run prepublish'

  # replace
  do ->
    replace = (require '../_libs/file').replace
    regStr = "else if\\(\"function\"==typeof define&&define.amd\\)define\\(e\\);"
    amdStr = 'else if("function"==typeof define&&define.amd)define(e);'
    cmdStr = 'else if("function"==typeof define&&define.cmd)define(function(require,exports,module){e()});'
    for distfile in distfiles
      replace distfile, regStr, "#{cmdStr}#{amdStr}"

  process.dmproj distfiles, distpath

  process.pubproj pubpath
