{ quote } = require '../lib/quote-words'

single = "'"
double = '"'

describe "empty selection", ->
    it "returns empty replacement", ->
        expect(quote('', single)).toEqual('')
        expect(quote('', double)).toEqual('')

describe "single word", ->
    it "returns quoted replacement", ->
        expect(quote('word', single)).toEqual("'word'")
        expect(quote('word', double)).toEqual('"word"')

describe "comma separated", ->
    it "quotes bare words", ->
        expect(quote('FOO, BAR, QUX', single)).toEqual("'FOO', 'BAR', 'QUX'")
        expect(quote('FOO, BAR, QUX', double)).toEqual('"FOO", "BAR", "QUX"')

describe "existing quotes", ->
    it "ignores same", ->
        expect(quote("'FOO'", single)).toEqual("'FOO'")
        expect(quote('"FOO"', double)).toEqual('"FOO"')
    it "updates to different", ->
        expect(quote('"FOO"', single)).toEqual("'FOO'")
        expect(quote("'FOO'", double)).toEqual('"FOO"')

describe "mixed input", ->
    it "updates where different", ->
        input = "\"FOO\", 'BAR',\nFOO_BAR\n, FIZZY_1 : Q-U-X"
        singled = "'FOO', 'BAR',\n'FOO_BAR'\n, 'FIZZY_1' : 'Q'-'U'-'X'"
        expect(quote(input, single)).toEqual(singled)
        doubled = '"FOO", "BAR",\n"FOO_BAR"\n, "FIZZY_1" : "Q"-"U"-"X"'
        expect(quote(input, double)).toEqual(doubled)

describe "complex input", ->
    it "behaves naively", ->
        expect(quote('https://github.com', single)).toEqual("'https'://'github'.'com'")
        expect(quote('https://github.com', double)).toEqual('"https"://"github"."com"')
