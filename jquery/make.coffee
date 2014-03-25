#!/usr/bin/env coffee
require 'shelljs/make'
echo = console.log

srcpath = "#{__dirname}/source"
distpath = "#{__dirname}/dist"

target.clean = ->
  rm "-rf", distpath

target.build = ->
  cd srcpath
  # check npm support
  unless test '-e', "#{srcpath}/node_modules"
    exec 'npm install --registry=http://registry.cnpmjs.org'
  # grunt
  exec 'grunt'
  # cp dist
  cp '-rf', "#{srcpath}/dist", "../"

target.publish = ->
  cd __dirname
  exec 'spm publish -f'

target.all = ->
  echo '>>> clean dist dir'
  target.clean()
  echo '>>> make dist'
  target.build()
  echo '>>> publish package'
  target.publish()
