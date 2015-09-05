minimatch         = require 'minimatch-ex'
Task              = require 'task-registry'
register          = Task.register
aliases           = Task.aliases
defineProperties  = Task.defineProperties

module.exports    = class ResourceTask
  register ResourceTask
  aliases ResourceTask, 'resource'

  @defineProperties: defineProperties
  defineProperties @,
    src: # limits the file patterns to process.
      type: ['String', 'Array']

  isMatchFile = (aOptions)->
    unless aOptions and aOptions.relative?
      throw new TypeError 'The options should be a resource object.'
    result = !aOptions.src
    unless result
      result = minimatch aOptions.relative, aOptions.src, aOptions
    result

  executeSync: (aOptions)->
    result = super aOptions if isMatchFile aOptions
    result

  execute: (aOptions, done)->
    try
      if isMatchFile aOptions
        super aOptions, done
      else
        done()
    catch err
      done(err)
