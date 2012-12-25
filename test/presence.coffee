get = Em.get
set = Em.set

Person = window.Person
person = window.person

describe "presence:", ->

  beforeEach ->

    Person = Em.Object.extend ValidateMixin,
      validations:
        name: "presence"

    person = Person.create
      name: ""

  afterEach ->
    person = null

  it "", ->

    person.validate()

    assert get(person, "_errors.name.msg") is ""
    assert get(person, "_errors.name._isValid") is false
    assert get(person, "_isValid") is false

    set person, "name", "Yehuda"
    person.validate()

    assert get(person, "_errors.name.msg") is undefined
    assert get(person, "_errors.name._isValid") is true
    assert get(person, "_isValid") is true
