chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
assert          = chai.assert
chai.use(sinonChai)

setImmediate    = setImmediate || process.nextTick

extend          = require 'util-ex/lib/_extend'
Task            = require 'task-registry'
register        = Task.register
aliases         = Task.aliases
ResourceTask    = require '../src'

class FakeResource
  constructor: (aOptions)->
    return new FakeResource(aOptions) unless @ instanceof FakeResource
    @relative = '.'
    extend @, aOptions if aOptions

class TestResourceTask
  register TestResourceTask, ResourceTask
  aliases TestResourceTask, 'Test', 'test'

  constructor: -> return super
  _executeSync: sinon.spy (aFile)->aFile

describe 'Resource Task', ->
  task = Task 'Test'
  beforeEach ->TestResourceTask::_executeSync.reset()

  describe 'executeSync', ->
    it 'should pass the resource obj', ->
      resource = FakeResource()
      result = task.executeSync resource
      expect(result).be.equal resource
      expect(TestResourceTask::_executeSync).be.calledOnce
    it 'should not pass the non-resource obj if src', ->
      should.throw task.executeSync.bind(task, {src:'*.md'}), 'should be a resource object.'
      expect(TestResourceTask::_executeSync).be.not.called
    it 'should filter the resource obj', ->
      resource = FakeResource(relative: '.git', src: '*.md')
      result = task.executeSync resource
      expect(result).be.undefined
      expect(TestResourceTask::_executeSync).be.not.called

  describe 'execute', ->
    it 'should pass the resource obj', (done)->
      resource = FakeResource()
      task.execute resource, (err, result)->
        unless err
          expect(result).be.equal resource
          expect(TestResourceTask::_executeSync).be.calledOnce
        done(err)
    it 'should not pass the non-resource obj if src', (done)->
      task.execute {src:'*.md'}, (err, result)->
        expect(err).to.be.instanceOf TypeError
        expect(result).be.undefined
        expect(TestResourceTask::_executeSync).be.not.called
        done()
    it 'should filter the resource obj', (done)->
      resource = FakeResource(relative: '.git', src: '*.md')
      task.execute resource, (err, result)->
        unless err
          expect(result).be.undefined
          expect(TestResourceTask::_executeSync).be.not.called
        done(err)
