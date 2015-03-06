grammar = require "../grammar.npm"

describe "testing the inputs", ->
  inputs = [
    # find statements
    "find *"
    "find foo"
    "find foo, bar"
    "find foo where v = ?"
    "find foo where v = ?, w = ?"
    "find foo where v in (?)"
    "find foo where v in (?, ? , ? )"
    # select statements
    "select"
  ]
  for input in inputs
    do (input) ->
      it "input string [#{input}] parses", ->
        grammar.parse(input)

