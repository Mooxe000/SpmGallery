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
  gutil.log (
    gutil.colors.red 'Hello',
    gutil.colors.green 'World',
    gutil.colors.cyan '!!!'
  )

gulp.task 'test', () ->
  pkgname = 'semantic-ui'
  pkgpath = "#{__dirname}/#{pkgname}"

  srcpath = "#{pkgpath}/source"
  pubpath = "#{pkgpath}/public"
  distpath = "#{pubpath}/dist"
  distfrom = "#{srcpath}/build/packaged"

  # check distpath
  checkdir distpath

  # clean distpath
  rm '-rf', "#{distpath}/*"

  # build project
  doindir srcpath, ->
    # check npm support
    unless test '-e', "#{srcpath}/node_modules"
      exec 'npm install'
    exec 'grunt'

  # demploy project
  cp '-R', "#{distfrom}/*", distpath

  # publist project
  doindir pubpath, ->
    exec 'spm publish -f'

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
