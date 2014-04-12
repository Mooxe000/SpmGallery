#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'

requestsync = require 'request-sync'
pkgdata = require './pkgdata'

spm =
  "alias":
    "modernizr": "modernizr"
  "output": ["modernizr-3.0.0pre.js"]

dfpkgjsonkeys = [
  'description'
  'repository'
  'keywords'
  'author'
  'license'
]

getWebPkgJson = (pkgname)->
  url = pkgdata.getPkgUpdateUrl(pkgname)
  response = requestsync url
  JSON.parse response.body

module.exports.getWebPkgJson = (pkgname) ->
  getWebPkgJson(pkgname)

handleName = (name) ->
  name = name.replace /bower/g, ''
  name = name.replace /\./g, '-'
  namearr = name.split ''
  namearr.shift() if namearr[0] is '-'
  namearr.pop() if namearr[namearr.length-1] is '-'
  namearr.join ''

handleVersion = (version) ->
  version = version.match /\d[\d\.]+\d/
  version[0]

module.exports.getSpmPkgJson = (pkgname) ->
  webpkgjson = getWebPkgJson(pkgname)
  spmpkgjson = {}
  spmpkgjson.family = 'bustling'
  spmpkgjson.name = handleName pkgdata[pkgname].name
  spmpkgjson.version = handleVersion webpkgjson.version
  for key in dfpkgjsonkeys
    if webpkgjson[key]
      spmpkgjson[key] = webpkgjson[key]
    else
      unless webpkgjson[key]
        log.info "Don\'t find the info of '#{key}'."
      else
        log.error "Failed to getting pkg #{key}\'s infomation."
        process.exit(-1)
  return spmpkgjson
