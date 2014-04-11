#!/usr/bin/env coffee

echo = console.log
Log = require 'log'
log = new Log 'info'

gutil = require 'gulp-util'

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

exports.checkdir = checkdir
exports.doindir = doindir