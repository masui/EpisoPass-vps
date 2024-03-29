#
# 正規表現の拡張を使ってEpisoPass問題を作る
#

hasDom = require 'has-dom'

Generator = require 're_expand'

generator = new Generator()

schools = "(kindergarten|elementary school|middle school|high school)"
time = "(昔|子供のころ|#{schools}のころ)"
freqgo = "(よく行ってた|行ったことがある|たまに行った)"
shops = "(本屋|床屋|散髪屋|レストラン|食堂|スーパー|市場|八百屋|魚屋|肉屋|店)"
recs = "(旅行|BBQ|バーベキュー)"
sports = "(baseball|football|hiking|climbing|surfing)"
events = "(コンサート|合宿|遠足|花見)"
animals = "(dog|cat|rabbit|rat|hamster)"
amusement = "(the thema park|Disneyland|the zoo)"
specialplace = "(the seashore|the top of the mountain|the shrine|the park|the sandbox)"

questions = [
  # 
  # Injuries
  # 
  "I had an (pain|injury) when I was going to #{schools}."
  "Bicycle collision"
  # "子供のころ体のどこを怪我したか"
  #
  # Colleagues / schoolmates
  #
  "Tallest person in the #{schools}"
  # "#{schools}のころ学校でよく暴れてた奴"
  # "#{schools}のころ一番嫌いだった奴"
  # "#{schools}のころ成績が(良かった|悪かった)奴"
  # "#{schools}のころ(図画|書道|ピアノ|リコーダー)が上手かった奴"
  # "(退学|留年)した奴"
  # "ボロいアパートに住んでた友達は"
  # "昔よく遊んだ友達"
  # "(ソフトボール|野球|ブラバン)の顧問の専門は"
  # "教室からいなくなるのは"
  # "押入れに変なものを隠してたのは"
  # "妙に部屋が綺麗だったのは"
  # "金持ち農家は"
  # 
  # 後悔
  # 
  # "やりたかったけどできなかった(楽器|スポーツ)は"
  "I wanted to practice (piano|guitar) when I was going to #{schools}."
  "I want to apologize for ..."
  #
  # Study, sport
  #
  "The place I used to enjoy #{sports} at #{schools}"
  "My (best|worst) score at math"
  # "走り幅跳びで飛んだ距離は"
  # "どうしても解けなかった問題は"
  # "昔からの志望校は"
  # "ベストを出したのは"
  #
  # Love / affair
  #
  "The person I (hated|liked|loved) in my #{schools} days."
  "The person I loved"
  "The person who (hated|liked|loved) me"
  "People who loved each other secretly"
  # "昔好きだった相手"
  # "昔振られた相手"
  # "片思いの相手は"
  # "嬉し恥ずかしかったのは"
  # "あまずっぱい思い出はどこで"
  #
  # Trip
  #
  "Places I visited when I was going to #{schools}"
  "Scared to death at (mountain|river|lake)"
  "Car engine stop"
  "Flat tire"
  "Lost in the city"
  "Stolen wallet on a trip"
  "Couldn't change (trains|buses|subways)"
  "Broken a bed in a hotel"
  "No paper in a toilet"
  "Strange thing at #{amusement}"
  "Terrible hotel"
  # "#{time}#{sports}したところ"
  # "昔#{events}に行ったところ"
  # "ひどかったホテルは"
  # "旅行先で迷ったのは"
  # "旅行で盗まれたもの"
  #
  # Food, restaurant
  #
  "The restaurant we went very often"
  "Kind of food I always ate at the restaurant"
  # "最初に美味しいと思った(ワイン|モルトウィスキー|ビール|料理)"
  # "昔嫌いだった食べ物"
  # "(2014|2015)忘年会の場所"
  # "#{schools}のときよく食べたのは"
  #
  # Failures
  #
  "Missed event because of circles"
  # "#{schools}のころの旅行先での(失敗|病気|怪我)"
  #
  # Houses and offices
  #
  # "#{time}#{freqgo}#{shops}"
  # "#{time}住んでたところの近くの(店|遊び場所)"
  # "#{time}住んでた家"
  # "#{time}#{recs}したところ"
  # "#{schools}のとき学校から見えた景色"
  # "(会社|オフィス|アパート)の(1F|2F|3F)にあるもの"
  # "#{time}の住所"
  # "#{time}の電話番号"
  # "市場の入口にあった店は"
  # #
  # # 勝負
  # # 
  # "背負い投げをくらったのは"
  # "ホームランだと思ったのにキャッチした奴は"
  # "役満を振込んだのは"
  # "役満振り込んだ瞬間に逃げ出したのは"
  # "小四喜を振込んだ相手"
  #
  # Lies, etc.
  #
  "Jellyfish lie"
  # "昔(嘘をついた|酷いことをしてしまった|持ち物を盗んだ|イジメた|ズルをした)相手"
  # "部活で壊した部品は"
  # "警察につかまったのは"
  # "隣家の柿を盗んだのは"
  # "横入りしたのは"
  #
  # Black history
  #
  "Blunder at job interview"
  "Flat tire"
  # "#{time}(喧嘩|柔道|テニス|バドミントン|相撲|かるた|トランプ|テスト)で負けた相手"
  # "いつもイジメられてた相手は"
  # "昔粗相をした場所"
  # "昔恥ずかしいところを見られた相手"
  # "(失敗した|ヘマをした)試験"
  # "迷子になった#{amusement}"
  # "(飲み会|宴会)で吐いた場所"
  # "(自転車|財布|バイク)を盗まれた場所"
  # "他人を知人と間違えたのは"
  # "カンニングした教科"
  # "食べたトマトを吐きかけてしまった相手"
  # "(カエル|ウンコ|ミミズ)を踏んでしまった場所"
  # "(駐車|スピード)違反でつかまったのは"
  # "滑って死にそうな目にあった山は"
  # "車のドアをぶつけたのは"
  #
  # Secrets
  #
  "What I hided at the back of the TV"
  "Hidden an app as a filetype"
  "Secret place for getting insects"
  #
  # Human relations
  #
  "Worst guy ever"
  "Always complaining something"

  # "実は(嫌いな|苦手な)人"
  # "#{schools}のころ嫌いだった先生"
  # "昔嫌いだった先生"
  # "かわいがってもらった先生"
  # "電池に関して嘘を教えた先生"
  # "酷い(上司|先輩)とは"
  # "(最高|最低)の(先輩|後輩)"
  # "本当は友達じゃないのは"
  # "不愉快な同僚は"
  # "恩知らずといえば"
  # "下宿の床を焦がした奴は"
  # "夜中に大声を出して迷惑だったのは"
  # "とんでもなかった隣人"
  # "苦労して買ってきた土産を捨てられて腹がたったのは"
  # "うっかり喧嘩しそうになったのは"
  # "ボートで助けてもらったのは"
  # "ボイコットしたのは"
  # "ありえない兄弟関係は"
  # "ギターがうるさかったのは"
  #
  # Animals
  #
  # "#{animals}に関する思い出"
  # "#{cat}にひっかかれた場所"
  # "犬にかまれた場所"
  "The place I saw a snake"
  #
  # First time experiences
  #
  "My first (car|motorcycle|bicycle|guiter|CD|phone|toy)"
  "First experience of (mountain climbing|camping|going abroad|airplain|bullet train)"
  #
  # Strange places
  #
  "Under the bridge are ..."
  "Forbidden places"
  #
  # Strange experiences
  #
  "Found a special thing at #{specialplace}"
  "Yelling at #{specialplace}"
  # "拾って驚いたもの"
  # "(サークル|部活)の部屋で(キス|エッチ)をしていたのは"
  # "CDを借りパク(した|された)のは"
  # "酒屋のおじさんのバックホームの返球は"
  # "カッターで指を切り落としたのは"
  # "空に放り上げたのは"
  # "(海|川)に捨てたのは"
  # "定期を届けた女の子の印象に残った部分は"
  #
  # Terrible experiences
  #
  # "小さい頃、2段ベッドにやってきたのは"
  # "落とした財布が戻って(きた|こなかった)のは"
  # "おみやげを投げ捨てたのは"
  # "万引きを疑われたことがある店は"
  # #
  # # よくわからない
  # #
  # "ぞうきん入れとは何か"
  # "ブタマンジュジュとは"
  # "滅多打ちであった とは"
  # "茶番が好評だったのは"
  # #
  # # 好きなアーティスト
  # # 
  # "展開が好きなアーティスト"
  # "印象的な建物"
  #
  # Dreams
  #
  # "よく見る夢は"
]

for q in questions
  generator.add q

if hasDom() # ブラウザでの実行
  ul = null

  f = (s, cmd) ->
    ul.append $('<li>').text(s)

  search = ->
    ul.remove() if ul
    ul = $('<ul>')
    $('body').append ul
    qstr = $('#q').val()
    generator.filter " #{qstr} ", f, 0

  $ ->
    search()
    $('#q').on 'keyup', search

else                                  # コマンドラインでの実行
  f = (a) -> console.log a

  for q in questions
    generator.add q

  generator.filter " ", f
