// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = function(obj, attr, options) {
  var val;
  val = get(obj, attr);
  if (Em.$.trim(val) === '') {
    return false;
  }
};
