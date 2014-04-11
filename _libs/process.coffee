#!/usr/bin/env coffee

echo = console.log
Log = require 'log'
log = new Log 'info'

require 'shelljs/global'

checkdir = (require './dir').checkdir
doindir = (require './dir').doindir

# check distpath
checkdist = (distpath) -> checkdir distpath

# clean distpath
cleandist = (distpath) ->
  rm '-rf', "#{distpath}/*"

# build project
buildproj = (srcpath) ->
  doindir srcpath, ->
    # check npm support
    unless test '-e', "#{srcpath}/node_modules"
      exec 'npm install'
    exec 'grunt'

# demploy project
dmproj = (distfiles, distpath) ->
  for distfile in distfiles
    cp '-R', distfile, distpath

# publist project
pubproj = (pubpath) ->
  doindir pubpath, ->
    exec 'spm publish -f'

exports.checkdist = checkdist
exports.cleandist = cleandist
exports.buildproj = buildproj
exports.dmproj = dmproj
exports.pubproj = pubproj

exports.default = (srcpath, distpath, distfiles, pubpath) ->
  checkdist distpath
  cleandist distpath
  buildproj srcpath
  dmproj distfiles, distpath
  pubproj pubpath
