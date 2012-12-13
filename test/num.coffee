global.window = require("jsdom").jsdom().createWindow()
jQuery = require("jquery")
require "handlebars"
require "ember"
global.window.Em = Ember

assert = require "assert"

get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "num:", ->

  beforeEach ->
    Person = Em.Object.extend require("./../index")

  afterEach ->
    person = null

  it "fail on string", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: "dew"
    person.validate()
    
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false

  
  it "pass if float", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: 22.0
    person.validate()

    assert get(person, "_errors.age.msg") is undefined
    assert get(person, "_isValid") is true

  
  it "pass if +ve with positive = true", ->

    Person = Person.extend
      validations:
        age:
          num:
            positive: true
    
    person = Person.create
      age: 0

    person.validate()
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false

    set person, "age", -22
    person.validate()
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false

    set person, "age", 22
    person.validate()
    assert get(person, "_errors.age.msg") is undefined
    assert get(person, "_isValid") is true


  it "pass if -ve with negative = true", ->

    Person = Person.extend
      validations:
        age:
          num:
            negative: true

    person = Person.create()

    set person, "age", 0
    person.validate()
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false

    set person, "age", 22
    person.validate()
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false

    set person, "age", -22
    person.validate()
    assert get(person, "_errors.age.msg") is undefined
    assert get(person, "_isValid") is true

  it "fail if 0 with zero==false", ->

    Person = Person.extend
      validations:
        age: "num"
    
    person = Person.create
      age: 0

    person.validate()
    assert get(person, "_errors.age.msg") is "invalid"
    assert get(person, "_isValid") is false


  it "pass if 0 with zero==true", ->

    Person = Person.extend
      validations:
        age:
          num:
            zero: true

    person = Person.create()

    set person, "age", 0
    person.validate()
    assert get(person, "_errors.age.msg") is undefined
    assert get(person, "_isValid") is true
