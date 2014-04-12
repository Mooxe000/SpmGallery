#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

pkgdata = require './pkgdata'

pkgs = pkgdata
pkgnames = pkgdata.getPkgList

name = "Front.Lib.Bustling"
version = "0.0.1"

bowerJsonObj = {}
dependencies = {}
exportsOverride = {}

getBowerJson = (pkgnames) ->
  for pkgname in pkgnames
    pkg = pkgs[pkgname]
    try
      dependencies[pkg.name] = "*"
      exportsOverride[pkg.name] = pkg.rule
    catch err
      log.error "WRAN: Package name is wrong."
      process.exit "-1"


  bowerJsonObj.name = name
  bowerJsonObj.version = version
  bowerJsonObj.dependencies = dependencies
  bowerJsonObj.exportsOverride = exportsOverride

  return bowerJsonObj

exports.getBowerJson = getBowerJson
