#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

require 'shelljs/make'
requestsync = require 'request-sync'
File = require 'file-utils'
replace = require 'replace'

srcpath = "#{__dirname}/source"
distpath = "#{__dirname}/dist"

target.update = ->
  html5shivUrl = 'https://raw.githubusercontent.com/aFarkas/html5shiv/master/src/html5shiv.js'
  html5printshivUrl = 'https://raw.githubusercontent.com/aFarkas/html5shiv/master/src/html5shiv-printshiv.js'
  cd "#{srcpath}/src"

  html5CmdWrap = (src) ->
    [
      "define(function() {"
      "  // Take the html5 variable out of the"
      "  // html5shiv scope so we can return it."
      "  var html5;"
      ""
      src
      "  return html5;"
      "});"
    ].join("\n")

  echo '>>> update html5shiv file'
  html5shivStr = (requestsync html5shivUrl).body
  html5shivStr = html5CmdWrap html5shivStr
  #  echo html5shivStr
  File.write "#{srcpath}/src/html5shiv.js", html5shivStr

  echo '>>> update html5printshiv file'
  html5printshivStr = (requestsync html5printshivUrl).body
  html5printshivStr = html5CmdWrap html5printshivStr
  #  echo html5printshivStr
  File.write "#{srcpath}/src/html5printshiv.js", html5printshivStr

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

target.rename = ->
  mv "#{distpath}/modernizr-build.js", "#{distpath}/modernizr.js"
  mv "#{distpath}/modernizr-build.min.js", "#{distpath}/modernizr.min.js"

target.publish = ->
  cd __dirname
  exec 'spm publish -f'

target.all = ->
  echo '>>> clean dist dir'
  target.clean()
  echo '>>> update html5shiv'
  target.update()
  echo '>>> make dist'
  target.build()
  echo '>>> rename dist file'
  target.rename()
  echo '>>> publish package'
  target.publish()

repfile = (tgfile, regStr, repStr) ->
  replace({
    regex: regStr,
    replacement: repStr,
    paths: [tgfile],
    recursive: true,
    silent: true,
  });
