#!/usr/bin/env coffee
'use strict'
echo = console.log
Log = require 'log'
log = new Log 'info'
_ = require 'lodash'

pkgs = {}

# Packages

## Modernizr
pkgs.modernizr =
  name: "modernizr"
  rule:
    "": ".bower.json"
    "js": [
      "modernizr.js"
    ]
  update: 'https://raw.github.com/Modernizr/Modernizr/master/package.json'

## Html5shiv
pkgs.html5shiv =
  name: "html5shiv"
  rule:
    "js": "dist/*.js"
  update: 'https://raw.github.com/aFarkas/html5shiv/master/bower.json'

## Respond
pkgs.respond =
  name: "respond"
  rule:
    "js": "dest/*.js"
  update: 'https://raw.github.com/scottjehl/Respond/master/package.json'

## PIE
pkgs.pie =
  name: "bower-pie"
  rule:
    "js": "build/*"
  update: 'https://raw.github.com/lukebussey/PIE/master/bower.json'

## Iscroll
pkgs.iscroll =
  name: "iscroll"
  rule:
    "js": "build/*"
  update: 'https://raw.github.com/cubiq/iscroll/master/package.json'

## Normalize
pkgs.normalize =
  name: "normalize.css"
  rule:
    "css": "normalize.css"
  update: "https://raw.github.com/necolas/normalize.css/master/package.json"

## Bootstrap
pkgs.bootstrap =
  name: "bootstrap"
  rule:
    "css": "dist/css/*"
    "js": "dist/js/*"
    "fonts": "dist/fonts/*"
  update: 'https://raw.github.com/twbs/bootstrap/master/package.json'

## Font-Awesome
pkgs.fontawesome =
  name: "font-awesome"
  rule:
    "css": "css/*"
    "fonts": "fonts/*"
  update: 'https://raw.github.com/FortAwesome/Font-Awesome/master/package.json'

## Pure
pkgs.pure =
  name: "pure"
  rule:
    "css": "pure.css"
  update: 'https://raw.github.com/yui/pure/master/package.json'

## Cikonss

## Foundation
pkgs.foundation =
  name: "bower-foundation"
  rule:
    "js": "js/*"
    "css": "css/*"
  update: 'https://raw.github.com/zurb/foundation/master/package.json'

## Foundation-Icon-Fonts
pkgs.foundationicons =
  name: "foundation-icons"
  rule:
    "css": "*/stylesheets/*"
    "fonts": "*/fonts/*"
  update: 'https://raw.github.com/zurb/foundation-icon-fonts/master/bower.json'

## Semantic-UI
pkgs.semanticui =
  name: "semantic-ui"
  rule:
    "css": "build/packaged/css/*"
    "fonts": "build/packaged/fonts/*",
    "images": "build/packaged/images/*"
    "js": "build/packaged/javascript/*"
  update: 'https://raw.github.com/Semantic-Org/Semantic-UI/master/package.json'

## Less
pkgs.less =
  name: "less.js"
  rule:
    "js": [
      "dist/less-1.7.0.js",
      "dist/less-1.7.0.min.js"
    ]
  update: 'https://raw.github.com/less/less.js/master/package.json'

## Coffee Script
#pkgs.coffeescript =
#  name: "coffee-script"
#  rule:
#    "js": "extras/*.js"
#  update: 'https://raw.github.com/jashkenas/coffee-script/master/package.json'

## Jade
pkgs.jade =
  name: "jade"
  rule:
    "js": [
      "jade.js"
      "runtime.js"
    ]
  update: 'https://raw.github.com/visionmedia/jade/master/package.json'

## Markdown
pkgs.markdown =
  name: "markdown"
  rule:
    "js": "lib/markdown.js"
  update: 'https://raw.github.com/evilstreak/markdown-js/master/package.json'

## prototype

## Jquery
pkgs.jquery =
  name: "jquery"
  rule:
    "js": [
      "dist/jquery.js",
      "dist/jquery.min.js",
      "dist/jquery.min.map"
    ]
  update: 'https://raw.github.com/jquery/jquery/master/package.json'

## zepto
pkgs.zepto =
  name: "zeptojs"
  rule:
    "js": "src/*"
  update: 'https://raw.github.com/madrobby/zepto/master/package.json'

pkgkeys = Object.keys pkgs

# check package name
checkPkgnames = (pkgnames) ->
  t_pkgnames = []
  if typeof pkgnames is 'string'
    t_pkgnames = pkgnames.split ","

  o_pkgnames = []
  for pkgname in t_pkgnames
    o_pkgnames.push pkgname if pkgs[pkgname]

  if o_pkgnames.length is 0
    o_pkgnames = pkgkeys

  return _.uniq o_pkgnames

module.exports = pkgs
module.exports.getPkgList = pkgkeys
module.exports.checkPkgnames = checkPkgnames
module.exports.getPkgUpdateUrl = (pkgname) ->
  pkgs[pkgname].update
module.exports.getPkgBowerNm = (pkgname) ->
  pkgs[pkgname].name
