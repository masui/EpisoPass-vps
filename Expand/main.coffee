#
# 正規表現の拡張を使ってEpisoPass問題を作る
#

Generator = require 're_expand'

generator = new Generator()

schools = "(幼稚園|小学生|中学生|高校生)"
time = "(昔|子供のころ|#{schools}のころ)"
freqgo = "(よく行ってた|行ったことがある|たまに行った)"
shops = "(本屋|床屋|散髪屋|レストラン|食堂|スーパー|市場|八百屋|魚屋|肉屋|店)"
recs = "(旅行|BBQ|バーベキュー)"
sports = "(野球|サッカー|ハイキング|サーフィン|散歩)"
events = "(コンサート|合宿|遠足|花見)"
animals = "(犬|猫|ウサギ|ネズミ)"

generator.add "#{time}(足|額|手|腕)を怪我した(場所|町)"
generator.add "#{schools}のころ学校でよく暴れてた奴"
generator.add "#{schools}のころ成績が(良かった|悪かった)奴"
generator.add "#{schools}のころ(図画|書道|ピアノ|リコーダー)が上手かった奴"
generator.add "#{time}#{freqgo}#{shops}"
generator.add "#{time}住んでたところの近くの(店|遊び場所)"
generator.add "#{time}住んでた家"
generator.add "#{time}(喧嘩|柔道|テニス|バドミントン|かるた|トランプ|テスト)で負けた相手"
generator.add "#{time}の住所"
generator.add "#{time}の電話番号"
generator.add "#{time}#{recs}したところ"
generator.add "#{time}#{sports}したところ"
generator.add "昔#{events}に行ったところ"
generator.add "昔(嘘をついた|酷いことをしてしまった)相手"
generator.add "昔粗相をした場所"
generator.add "昔恥ずかしいところを見られた相手"
generator.add "昔振られた相手"
generator.add "昔好きだった相手"
generator.add "実は(嫌いな|苦手な)人"
generator.add "#{schools}のころ嫌いだった先生"
generator.add "昔嫌いだった食べ物"
generator.add "#{animals}に関する思い出"

div = null

f = (s, cmd) ->
  div.append $('<li>').text(s)

search = ->
  div.remove() if div
  div = $('<div>')
  $('body').append div
  qstr = $('#q').val()
  generator.filter " #{qstr} ", f, 0

$ ->
  search()
  $('#q').on 'keyup', search
