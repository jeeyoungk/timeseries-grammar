grammar = require "../grammar.npm"

describe "testing the parser ", ->
  valid_inputs = [
    # show statements
    "show *"
    "show foo"
    "show foo, bar"
    "show foo where v = 'a'"
    "show foo where v = 'a', w = 'b'"
    "show foo where v in ('a')"
    "show foo where v in (a, b, c)"
    "show foo where v in ('a', 'b', 'c')"
    # select statements
    "select x"
    "select x, y, z"
    "select x where v = 'a'"
    "select max(x), min(x)"
    "select max(x) where x.hostname = 'a'"
    "select x + y"
    "select x + y * (z - 2) / 2"
    "select x.y.z"
    "select x group by hostname"
    'select x range ("3 hours ago", ?)'
    "select x range ('3 hours ago', ?)"
    "select x sample to 5 minute by min"
    "select x sample to 5 minute by max"
    "select x sample to 5 minute by sum"
    "select x sample to 5 minute by mean"
  ]
  invalid_inputs = [
    "select;"
  ]
  for input in valid_inputs
    do (input) ->
      it "input string [#{input}] parses", ->
        parsed = grammar.parse(input)

  for input in invalid_inputs
    do (input) ->
      it "input string [#{input}] doesn't parse", ->
        expect(-> grammar.parse(input)).toThrow()

describe "testing the parse tree", ->
  valid_inputs = [
    # "show apple, banana where v in (apple, banana), w = a"
    "select x sample to 5 minute by min"
  ]
  for input in valid_inputs
    do (input) ->
      it "input string [#{input}] parses", ->
        parsed = grammar.parse(input)
        console.log JSON.stringify(parsed, null, 2)

