#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

require 'shelljs/make'

srcpath = "#{__dirname}/source"
distpath = "#{__dirname}/dist"

setdir = (dir) ->
  pwd = process.cwd()
  unless pwd is dir
    cd dir

target.clean = ->
  rm "-rf", distpath

target.mkdist = ->
  unless test '-e', distpath
    mkdir '-p', distpath

target.dmdist = ->
  setdir __dirname
  cp '-R', "#{srcpath}/build/packaged/*", distpath

target.publish = ->
  setdir __dirname
  exec "spm publish -f"

target.all = ->
  echo ">>> clean dist"
  target.clean()
  echo ">>> mkdir dist"
  target.mkdist()
  echo ">>> demploy dist"
  target.dmdist()
  echo ">>> publish"
  target.publish()