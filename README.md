## task-registry-resource [![npm](https://img.shields.io/npm/v/task-registry-resource.svg)](https://npmjs.org/package/task-registry-resource)

[![Build Status](https://img.shields.io/travis/snowyu/task-registry-resource.js/master.svg)](http://travis-ci.org/snowyu/task-registry-resource.js)
[![Code Climate](https://codeclimate.com/github/snowyu/task-registry-resource.js/badges/gpa.svg)](https://codeclimate.com/github/snowyu/task-registry-resource.js)
[![Test Coverage](https://codeclimate.com/github/snowyu/task-registry-resource.js/badges/coverage.svg)](https://codeclimate.com/github/snowyu/task-registry-resource.js/coverage)
[![downloads](https://img.shields.io/npm/dm/task-registry-resource.svg)](https://npmjs.org/package/task-registry-resource)
[![license](https://img.shields.io/npm/l/task-registry-resource.svg)](https://npmjs.org/package/task-registry-resource)

Resource Task is an abstract [resource][resource-file] processing task.
It's registered to [task-registry][task-registry] which is a  task register and manager.
It adds the `src` property for the file patterns to limit the files to be processed.
the passed `aOptions` is a [resource][resource-file] file object.

## Usage

```coffee
Resource  = require 'task-registry-resource'
MyTask    = require 'task-registry-my'

echoSyncFn = (v)->v
register echoSyncFn, MyTask, 'echo' #register the echoSyncFn to MyTask.

echoFn = (v, cb)->cb(null, v)
register echoFn, MyTask, name:'echo', async:true #register the echoFn to MyTask.
```

## API


## TODO


## License

MIT


[task-registry]: https://github.com/snowyu/task-registry.js
[resource-file]: https://github.com/snowyu/resource-file.js
