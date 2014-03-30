#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

require 'shelljs/make'

srcpath = "#{__dirname}/source"
distpath = "#{__dirname}/dist"

target.clean = ->
  rm "-rf", distpath

target.build = ->
  cd srcpath
  # check npm support
  unless test '-e', "#{srcpath}/node_modules"
    exec 'npm install'
  # grunt
  exec 'grunt'

target.demdist = ->
  unless test '-e', distpath
    mkdir '-p', distpath
  cp '-rf', "#{srcpath}/build/pure.css", distpath
  cp '-rf', "#{srcpath}/build/pure-min.css", distpath
  mv "#{distpath}/pure-min.css", "#{distpath}/pure.min.css"

target.publish = ->
  cd __dirname
  exec 'spm publish -f'

target.all = ->
  echo '>>> clean dist dir'
  target.clean()
  echo '>>> make dist'
  target.build()
  echo '>>> demploy dist file'
  target.demdist()
  echo '>>> publish package'
  target.publish()
