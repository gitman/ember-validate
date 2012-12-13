// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = Em.Mixin.create({
  validators: {
    presence: require('./lib/presence'),
    max: require('./lib/max'),
    min: require('./lib/min'),
    re: require('./lib/re'),
    email: require('./lib/email'),
    num: require('./lib/num')
  },
  init: function() {
    var attr, that, validations, validator, _results;
    this._super();
    that = this;
    validations = get(this, "validations");
    set(this, "_errors", Em.Object.create());
    _results = [];
    for (attr in validations) {
      validator = validations[attr];
      _results.push(set(that, "_errors." + attr, {
        msg: void 0,
        isValid: true
      }));
    }
    return _results;
  },
  validate: function() {
    var attr, isValid, options, that, validate, validations, validator, validators, _ref, _results;
    that = this;
    validators = get(this, "validators");
    set(this, "_isValid", true);
    validate = function(validator, options) {
      var isValid, msg, _options;
      if (options.constructor.name !== "Object") {
        _options = options;
        options = {};
        options[validator] = _options;
      }
      options["obj"] = that;
      options["attr"] = attr;
      validator = validators[validator].create(options);
      isValid = validator.validate() === false ? false : true;
      msg = isValid ? void 0 : get(validator, "msg");
      set(that, "_errors." + attr, {
        msg: msg,
        _isValid: isValid
      });
      return isValid;
    };
    _ref = get(this, "validations");
    _results = [];
    for (attr in _ref) {
      validations = _ref[attr];
      if (typeof validations === "string") {
        validator = validations;
        isValid = validate(validator, {});
        if (isValid === false) {
          set(that, "_isValid", false);
          break;
        } else {
          _results.push(void 0);
        }
      } else {
        _results.push((function() {
          var _results1;
          _results1 = [];
          for (validator in validations) {
            options = validations[validator];
            isValid = validate(validator, options);
            if (isValid === false) {
              set(that, "_isValid", false);
              break;
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        })());
      }
    }
    return _results;
  }
});
