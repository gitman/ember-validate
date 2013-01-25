// Generated by CoffeeScript 1.4.0
var Person, get, person, set, textField;

get = Em.get;

set = Em.set;

Person = person = textField = void 0;

describe('input:', function() {
  beforeEach(function() {
    Person = Em.Object.extend(ValidateMixin, {
      validations: {
        email: ['presence', 'email']
      }
    });
    person = Person.create({
      email: ''
    });
    textField = Em.TextField.create({
      "for": 'email',
      valueBinding: 'context.email',
      context: person
    });
    return Em.run(function() {
      return textField.append();
    });
  });
  afterEach(function() {
    person = null;
    return textField.destroy();
  });
  it("input's @error==undefined and @isValid==true", function() {
    assert.equal(get(textField, 'value'), '');
    assert.equal(get(textField, 'error'), void 0);
    assert.equal(get(textField, 'isValid'), true);
    return assert.equal(textField.$().hasClass('error'), false);
  });
  it('inputs have .error class when value becomes inValid', function() {
    person.validate();
    assert.equal(get(textField, 'value'), '');
    assert.equal(get(textField, 'error'), '');
    assert.equal(get(textField, 'isValid'), false);
    assert.equal(textField.$().hasClass('error'), true);
    Em.run(function() {
      set(person, 'email', 'g');
      return person.validate();
    });
    assert.equal(get(textField, 'value'), 'g');
    assert.equal(get(textField, 'error'), '¬ wrong email format');
    assert.equal(get(textField, 'isValid'), false);
    return assert.equal(textField.$().hasClass('error'), true);
  });
  return it('inputs value is ok', function() {
    Em.run(function() {
      set(person, 'email', 'g@g.g');
      return person.validate();
    });
    assert.equal(get(textField, 'value'), 'g@g.g');
    assert.equal(get(textField, 'error'), void 0);
    assert.equal(get(textField, 'isValid'), true);
    return assert.equal(textField.$().hasClass('error'), false);
  });
});