#!/usr/bin/env coffee
require 'shelljs/global'
gulp = require 'gulp'
gutil = require 'gulp-util'
argv = (require 'yargs').argv

pkglist = [
  'modernizr'
  'pure'
  'font-awesome'
  'semantic-ui'
  'jquery'
  'coffee-script'
  'less'
]

gulp.task 'default', ->
  do pure
  do SemanticUi

modernizr = ->
  pkgname = 'pure'
  pkgpath = "#{__dirname}/#{pkgname}"

  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"

  distfiles = [
    "#{srcpath}/build/pure.css"
    "#{srcpath}/build/pure-min.css"
  ]

  checkdist distpath
  cleandist distpath
  buildproj srcpath
  dmproj distfiles, distpath
  pubproj pubpath

pure = ->
  pkgname = 'pure'
  pkgpath = "#{__dirname}/#{pkgname}"

  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"

  distfiles = [
    "#{srcpath}/build/pure.css"
    "#{srcpath}/build/pure-min.css"
  ]

  checkdist distpath
  cleandist distpath
  buildproj srcpath
  dmproj distfiles, distpath
  pubproj pubpath

SemanticUi = ->
  pkgname = 'semantic-ui'
  pkgpath = "#{__dirname}/#{pkgname}"

  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"
  distfiles = [ "#{srcpath}/build/packaged/*" ]

  checkdist distpath
  cleandist distpath
  buildproj srcpath
  dmproj distfiles, distpath
  pubproj pubpath

checkdir = (dirpath) ->
  unless test '-e', "#{dirpath}"
    gutil.log (
      gutil.colors.red 'WRAN::',
        'This folder does not exist.'
    )
    gutil.log (
      'Creating the folder...'
    )
    mkdir '-p', dirpath
    if test '-e', dirpath
      gutil.log (
        gutil.colors.green 'SUCCESS::',
          'The folder is created successfully.'
      )
    else
      gutil.log (
        gutil.colors.red 'WRAN::',
          'The folder creation fails.'
      )
      process.exit()

doindir = (cddir, dosth) ->
  pwd = process.cwd()
  unless pwd is cddir
    cd cddir
  do dosth
  cd pwd

# check distpath
checkdist = (distpath) -> checkdir distpath

# clean distpath
cleandist = (distpath) -> rm '-rf', "#{distpath}/*"

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
