// Generated by CoffeeScript 1.4.0
var Em, get, set;

Em = window.Em;

get = Em.get;

set = Em.set;

module.exports = function(obj, attr, options) {
  var expr, val;
  val = get(obj, "" + attr + ".length");
  expr = options.replace('@', val);
  if (!eval(expr)) {
    return [false, "¬ !length: " + expr];
  }
};
