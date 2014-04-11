#!/usr/bin/env coffee

echo = console.log
gutil = require 'gulp-util'
log = gutil.log

process = require '../_libs/process'
requestsync = require 'request-sync'
File = require 'file-utils'

exports.run = ->
  pkgpath = "#{__dirname}"
  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"

  distfiles = [
    "#{srcpath}/dist/*"
  ]

  process.checkdist distpath
  process.cleandist distpath

  # Update html5shiv
  do ->
    html5shivUrl = 'https://raw.githubusercontent.com/aFarkas/html5shiv/master/src/html5shiv.js'
    html5printshivUrl = 'https://raw.githubusercontent.com/aFarkas/html5shiv/master/src/html5shiv-printshiv.js'
    cd "#{srcpath}/src"

    html5CmdWrap = (src) ->
      """
        define(function() {
          // Take the html5 variable out of the
          // html5shiv scope so we can return it.
          var html5;

        #{src}
          return html5;
        });
        """

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

  process.buildproj srcpath
  process.dmproj distfiles, distpath

  # Rename dist file
  do ->
    mv "#{distpath}/modernizr-build.js", "#{distpath}/modernizr.js"
    mv "#{distpath}/modernizr-build.min.js", "#{distpath}/modernizr.min.js"

  process.pubproj pubpath
