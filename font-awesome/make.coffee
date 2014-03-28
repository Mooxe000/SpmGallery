#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

require 'shelljs/global'
require 'shelljs/make'

srcpath = "#{__dirname}/bower_components/font-awesome"
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
  # install
  exec 'bower install font-awesome'
  # move to dist
  cp '-R', "#{srcpath}/css", distpath
  cp '-R', "#{srcpath}/fonts", distpath
  # remove bower_compoenets
  rm '-rf', "#{__dirname}/bower_components/"

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
