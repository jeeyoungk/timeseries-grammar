grammar = require "../grammar.npm"

describe "testing the inputs", ->
  inputs = [
    # show statements
    "show *"
    "show foo"
    "show foo, bar"
    "show foo where v = ?"
    "show foo where v = ?, w = ?"
    "show foo where v in (?)"
    "show foo where v in (?, ? , ? )"
    # select statements
    "select x"
    "select x, y, z"
    "select x where v = ?"
    "select max(x), min(x)"
    "select max(x) where x.hostname = ?"
    "select x + y"
    "select x + y * (z - 2) / 2"
    "select x.y.z"
    "select x group hostname"
  ]
  for input in inputs
    do (input) ->
      it "input string [#{input}] parses", ->
        grammar.parse(input)

