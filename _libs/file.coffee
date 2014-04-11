#!/usr/bin/env coffee

echo = console.log
Log = require 'log'
log = new Log 'info'

replace = (tgfile, regStr, repStr) ->
  replace = require 'replace'
  replace({
    regex: regStr,
    replacement: repStr,
    paths: [tgfile],
    recursive: true,
    silent: true,
  });

exports.replace = replace
