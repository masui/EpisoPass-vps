#
#  episopass.coffee - EpisoPass本体
# 
#  Toshiyuki Masui @ Pitecan.com
#  Last Modified: 2015/10/31 19:12:53
# 
#  var json = '<%= @json %>';
#  var name = '<%= @name %>';
#  var seed = '<%= @seed %>';
#

data = JSON.parse json
qas = data['qas']
curq = 0
cura = 0

answer = []             # answer[q] = a ... q番目の質問の答がa番目である

crypt = if typeof require == 'undefined' then exports else require('./crypt.js') # nodeでもブラウザJSでも動かす工夫

selfunc = (q,a) -> # q番目の質問のa番目の選択肢をクリックしたとき呼ばれる関数
  ->
    answer[q] = a
    [0...qas[q]['answers'].length].forEach (i) ->
      $("#answer#{q}-#{i}").css 'background-color', if i == a then '#ccf' else '#fff'
    calcpass true

editfunc = (q,a) -> # q番目の質問のa番目の選択肢を編集したとき呼ばれる関数
  ->
    curq = q
    cura = a
    qas[q]['answers'][a] = $("#answer#{q}-#{a}").val()
    calcpass()

timeout = null
hover_in_func = (q,a) ->
  ->
    timeout = setTimeout selfunc(q,a), 400
hover_out_func =  ->
  ->
    clearTimeout timeout

# f4ba35ab6069e8bcf9ef62bf73d12fd1.png のような表示
answerspan = (q,a) -> # q番目の質問のa番目の選択肢のspan
  aspan = $('<span class="answer">')
  input = $('<input type="text" autocomplete="off" class="answer">')
    .val qas[q]['answers'][a]
    .attr 'id', "answer#{q}-#{a}"
    .css 'background-color', if a == 0 then '#ccf' else '#fff'
    .on 'click', selfunc(q,a)
    .on 'keyup', editfunc(q,a)
    # .hover hover_in_func(q,a), hover_out_func()
  aspan.append(input)

showimage = (str,img) ->
  if str.match /\.(png|jpeg|jpg|gif)$/i
    img.attr 'src',str
      .css 'display','block'
  else
    img.css 'display','none'

qeditfunc = (q) -> # q番目の問題を編集したとき呼ばれる関数
  ->
    str = $("#question#{q}").val()
    qas[q]['question'] = str
    img = $("#image#{q}")
    showimage(str,img)
    calcpass()

minusfunc = (q) -> # q番目の問題の「-」ボタンを押したとき呼ばれる関数
  ->
    qas[q]['answers'].pop()
    $("#answer#{q}-#{qas[q]['answers'].length}").remove()

plusfunc = (q) -> # q番目の問題の「+」ボタンを押したとき呼ばれる関数
  ->
    nelements = qas[q]['answers'].length
    qas[q]['answers'].push '新しい回答例'
    $("#delim#{q}").before answerspan(q,nelements)

qadiv = (q) -> # q番目の質問+選択肢のdiv
  answer[q] = 0
  div = $("<div class='qadiv'>")  # !!!!!!!clssが変
    .attr 'id', "qadiv#{q}"
  qdiv = $('<div width="100%" class="qdiv">')
  qstr = qas[q]['question']
  qinput = $('<input type="text" autocomplete="off" class="qinput">')
    .attr 'id', "question#{q}"
    .val qstr
    .on 'keyup', qeditfunc(q)
  qdiv.append qinput
  div.append qdiv
    
  img = $("<img class='qimg'>")
    .attr 'id', "image#{q}"
  div.append img
  showimage qstr, img
    
  ansdiv = $("<div class='ansdiv'>")
  [0...qas[q]['answers'].length].forEach (i) ->
    ansdiv.append answerspan(q,i)
  delim = $('<span>  </span>')
    .attr 'id', "delim#{q}"
  ansdiv.append delim
    
  minus = $('<input type="button" value=" - ">')
    .on 'click', minusfunc(q)
  ansdiv.append minus
  ansdiv.append $('<span>  </span>')
    
  plus = $('<input type="button" value=" + ">')
    .on 'click', plusfunc(q)
  ansdiv.append plus
  div.append ansdiv
    .append $('<br clear="all">')

maindiv = ->
  $("#main").children().remove()  # ブラウザから「別名で保存」すると #main に入れたデータが全部格納されてしまうので、最初に全部消しておく

  [0...qas.length].forEach (i) ->
    $("#main").append qadiv(i)

  minus = $('<input type="button" value=" - " id="qa_minus" class="qabutton">')
    .click (event) -> # 質問の数を減らす「-」ボタンをクリックしたとき呼ばれる関数
      qas.pop()
      $("#qadiv#{qas.length}").remove()
      calcpass()
  $("#main").append minus
    
  $("#main").append $('<span>  </span>')
    
  plus = $('<input type="button" value=" + " class="qabutton">')
    .click (event) -> # 質問の数を増やす「-」ボタンをクリックしたとき呼ばれる関数
      qas.push
        question: "新しい質問"
        answers:  ["回答11","回答22","回答33"]
      $("#qa_minus").before qadiv(qas.length-1)
      calcpass()
  $("#main").append plus

secretstr = -> # 質問文字列と選択された文字列をすべて接続した文字列
  [0...qas.length].map (i) ->
    qas[i]['question'] + qas[i]['answers'][answer[i]]
  .join ''

calcpass = (copy) -> # シード文字列からパスワード文字列を生成
  newpass = crypt.crypt $('#seed').val(), secretstr()
  $('#pass').val newpass

  #if copy
  #  $('#pass').select()
  #  document.execCommand 'copy' # コピーバッファにコピー
  #  $('#pass').blur()
  #  $("#answer#{curq}-#{cura}").select()

calcseed = -> # パスワード文字列からシード文字列を生成
  newseed = crypt.crypt $('#pass').val(), secretstr()
  $('#seed').val newseed
  data['seed'] = newseed

sendfile = (files) ->
  file = files[0]
  fileReader = new FileReader()
  fileReader.onload = (event) ->
    json = event.target.result # 読んだファイルの内容
    $("#main").children().remove()
    data = JSON.parse json
    qas = data['qas']
    maindiv()
    calcpass()
  fileReader.readAsText file
  false

save = () ->
  data['seed'] = $('#seed').val()
  $.ajax
    type: "POST"
    async: true
    url: "/#{name}/__write"
    data: "data=#{JSON.stringify(data)}"

$ ->
  $('#seed').keyup (e) ->
    data['seed'] = $('#seed').val()
    calcpass()
  $('#pass').keyup (e) ->
    calcseed()
  $("#save").click ->
    save()
  $("#das").click ->
    window.open().location.href="http://EpisoPass.com/EpisoDASMaker.html?name=#{name}&selections=#{answer.join(',')}&seed=#{$('#seed').val()}"
  $("#apk").click ->
    save()
    location.href = "/#{name}.apk"

  if ! location.href.match(/^http/)
    $('#save').css 'display', 'none'
    $('#apk').css 'display','none'
    
  $('#seed').val seed
    
  $('#qa_json').click (event) ->
    event.preventDefault()
    d = JSON.stringify data
    blob = new Blob [d], {type: "text/plain;charset=utf-8"}
    saveAs blob, "qa.json"
    
  # Drag&Drop対応
  $('body')
    .bind "dragover", (e) ->
      false
    .bind "dragend", (e) ->
      false
    .bind "drop", (e) ->
      e.preventDefault() # デフォルトは「ファイルを開く」
      files = e.originalEvent.dataTransfer.files
      sendfile files
      files

  #
  # backボタンで戻ったときなど再表示する
  #
  $(window).on 'pageshow', ->
    maindiv()
    
  maindiv()
  calcpass()
