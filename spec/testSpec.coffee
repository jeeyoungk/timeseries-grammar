grammar = require "../grammar.npm"

"""
Design:

 * implicit join behavior between different metrics.
 * WHERE tag = restricts to everything.
 * WHERE table.tag = restricts only to a given tag.
 * no subqueries.
"""
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
    "show * where v = 'apple', w in (banana, \"cherry\")"
    # select statements
    "select cpu.abc where datacenter = sjc1b"
    "select cpu, memory where host = apa1 and dc = sjc1b"
    "select x"
    "select (x)"
    "select ((x))"
    "select (((x)))"
    "select x, y, z"
    "select x where v = 'a'"
    "select max(x), min(x)"
    "select max(x) where x.hostname = 'a'"
    "select x + y"
    "select x + y * (z - 2) / 2"
    "select x.y.z"
    "select x group by hostname" # would be invalid, since group by.
    'select x range ("3 hours ago", "now")'
    "select x range ('3 hours ago', 'now')"
    "select x sample to 5 minute by min"
    "select x sample to 5 minute by max"
    "select x sample to 5 minute by sum"
    "select x sample to 5 minute by mean"
    "select x from a b, c d"
    "select x from a as b, c as d"
    # select is optional
    "selectx"
    "showx"
    # semantics
    # always JOIN on same columns.
    "x"
    "x + y"
    "max(x) + max(y)"
    "max(x + y)" # join first, then group.
    "max(x + max(y))" # max first, then join, then group.
    "
    sum(failure) / (sum(success) + sum(failure))
    from api.metric success, api.metric failure
    where success.type = 'success', failure.type = 'failure'
    group by api
    "
    "
    sum(qps) / sum(totalQps)
    from qps as qps, qps as totalQps
    where app = 'esperanto'
    group by action, totalQps.env
    "
    # The examples of hard queries that we want to perform.
  ]
  invalid_inputs = [
    "select;"
    "show foowhere v = v"
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
    "select x range ('3 hours ago', 'now') sample to 5 minute by min"
  ]
  for input in valid_inputs
    do (input) ->
      it "input string [#{input}] parses", ->
        parsed = grammar.parse(input)

