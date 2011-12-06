stylus = require 'stylus'

{Compiler} = require './base'

# NIB is an official stylus library of useful mixins etc.
# just like Compass.
try
  nib = require('nib')()
catch error
  null

class exports.StylusCompiler extends Compiler
  patterns: [/\.styl$/]

  map: (file, callback) ->
    compiler = stylus(file)
      .set('compress', yes)
      .set('firebug', @options.stylus?.firebug)

    if typeof @options.stylus?.paths is 'object'
      paths = (@getRootPath stylusPath for stylusPath in @options.stylus.paths)
      compiler.set('paths', paths)

    compiler.use nib if nib
    compiler.render callback
