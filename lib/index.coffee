Em = window.Em
get = Em.get
set = Em.set

REGEX_EXPRS = Em.Object.create
  #presence: [/^.+$/mi, '']
  email: [/.+@.+\..+/, '¬ wrong email format']

# mixin to apply to objects
module.exports = Em.Mixin.create

  _isValid: true
  _errors: {}

  validate: ->

    that = @

    isValid = true

    validations = get that, 'validations'

    for attr, validators of validations

      for item in validators

        [
          isValid
          error
        ] = do ->

          options = {}

          if item instanceof Array
            [
              item
              error
            ] = item
          
          if typeof item is 'string'
            fn = item
            options = get REGEX_EXPRS, "#{fn}"
            if options
              fn = 're'
              [
                options
                _error
              ] = options

          else if item instanceof RegExp
            fn = 're'
            options = item

          else if typeof item is 'function'
            fn = item

          else
            
            keys = Object.keys item
            fn = keys[0]
            options = item[fn]

          #
          if typeof fn is 'string'
            fn = require "./validators/#{fn}"

          result = fn that, attr, options
          if result instanceof Array
            [
              isValid
              __error
            ] = result
          else
            isValid = result

          isValid ?= true

          #console.log "#{error} - #{_error} - #{__error}"
          #console.log isValid

          error ?= _error ?= __error ?= ''

          [
            isValid
            error
          ]
          
        if isValid is false
          set that, "_errors.#{attr}", error
          break
        else
          set that, "_errors.#{attr}", undefined
      
      if isValid is false
        break

    set that, '_isValid', isValid