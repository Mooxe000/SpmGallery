#!/usr/bin/env coffee
'use strict'
version = '0.0.1'
echo = console.log
Log = require 'log'
log = new Log 'info'

fs = require "fs"
commander = require "commander"
require 'shelljs/global'

pkgdata = require './lib/pkgdata'
pkgjson = require './lib/pkgjson'
bwrjson = require './lib/bwrjson'

## commander
commander
  .version version
  .usage '[commanders] <packages ...>'

## commander list
commander
  .command "list"
  .description "List packages that can be installed."
  .action -> echo JSON.stringify pkgdata.getPkgList, null, 2

# commander json
fixpath = (path) ->
  try
    last = (path.split "").splice "-1"
    unless last[0] is "/"
      path += "/"
  catch err
    path = "./"
  return path

commander
  .command "json [jsonname] [pkgnames]"
  .option "-o, --output [path]", "Set json save path."
  .description "Echo && save package's package.json && bower.json."
  .action (jsonname, pkgnames, options) ->
    path = options.output
    typepath = typeof path
    switch typepath
      when 'string'
        path = fixpath(path) if typepath
      when 'boolean'
        path = './'
      else
        path = false
    pkgnames = pkgdata.checkPkgnames pkgnames
    switch jsonname
      when 'bower'
        bowerjson = bwrjson.getBowerJson pkgnames
        bowerJsonStr = JSON.stringify bowerjson, null, 2
        if path
          fs.writeFileSync "#{path}bower.json",
            bowerJsonStr, "UTF-8", 'flags': 'w'
        else
          echo bowerJsonStr
      when 'package'
        unless pkgnames.length is 1
          log.error "WRAN: Only one package canbe handle."
          process.exit(-1)
        pkgname = pkgnames[0]
        pkgjsonobj = pkgjson.getSpmPkgJson(pkgname)
        pkgjsonstr = JSON.stringify pkgjsonobj, null, 2
        if path
          fs.writeFileSync "#{path}package.json",
            pkgjsonstr, "UTF-8", 'flags': 'w'
        else
          echo pkgjsonstr
      else
        log.error "WRAN: Jsonname must be package or bower."
        do help
        process.exit(-1)

## commonder help
help = ->
  exec "coffee '#{__filename}' --help"

commander
  .command '*'
  .action ->
    do help

if process.argv.length is 2
  do help

commander.parse process.argv