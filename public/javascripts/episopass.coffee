#
#  var json = '<%= @json %>';
#  var name = '<%= @name %>';
#  var seed = '<%= @seed %>';
#

data = JSON.parse json
qas = data['qas']

answer = []             # answer[q] = a ... q番目の質問の答がa番目である

# Crypt = new Crypt()
crypt = if typeof require == 'undefined' then exports else require('./crypt.js')

selfunc = (q,a) -> # 選択肢クリック時の関数
  ->
    answer[q] = a
    [0...qas[q]['answers'].length].forEach (i) ->
      $("#answer#{q}-#{i}").css 'background-color', if i == a then '#ccf' else '#fff'
    calcpass()

editfunc = (q,a) -> # 選択肢編集時の関数
  ->
    qas[q]['answers'][a] = $("#answer#{q}-#{a}").val()
    calcpass()

timeout = null
hover_in_func = (q,a) ->
  ->
    timeout = setTimeout selfunc(q,a), 400
hover_out_func =  ->
  ->
    clearTimeout timeout

answerspan = (q,a) -> # q番目の質問のa番目の選択枝のspan
  aspan = $('<span class="answer">')
  input = $('<input type="text" autocomplete="off" class="answer">')
    .val qas[q]['answers'][a]
    .attr 'id', "answer#{q}-#{a}"
    .css 'background-color', if a == 0 then '#ccf' else '#fff'
    .on 'click', selfunc(q,a)
    .on 'keyup', editfunc(q,a)
    .hover hover_in_func(q,a), hover_out_func()
  aspan.append(input)

showimage = (str,img) ->
  if str.match /\.(png|jpeg|jpg|gif)$/i
    img.attr 'src',str
      .css 'display','block'
  else
    img.css 'display','none'

qeditfunc = (q) -> # 問題編集時の関数
  ->
    str = $("#question#{q}").val()
    qas[q]['question'] = str
    img = $("#image#{q}")
    showimage(str,img)
    calcpass()

minusfunc = (q) ->
  ->
    qas[q]['answers'].pop()
    $("#answer#{q}-#{qas[q]['answers'].length}").remove()

plusfunc = (q) ->
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
    
  img = $("<img>")
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
  # ブラウザから「別名で保存」すると #main に入れたデータが全部格納されて
  # しまうので、最初に全部消しておく
  $("#main").children().remove()

  [0...qas.length].forEach (i) ->
    $("#main").append qadiv(i)

  minus = $('<input type="button" value=" - " id="qa_minus" class="qabutton">')
    .click (event) ->
      qas.pop()
      $("#qadiv#{qas.length}").remove()
      calcpass()
  $("#main").append minus
    
  $("#main").append $('<span>  </span>')
    
  plus = $('<input type="button" value=" + " class="qabutton">')
    .click (event) ->
      qas.push
        question: "新しい質問"
        answers:  ["回答11","回答22","回答33"]
      $("#qa_minus").before qadiv(qas.length-1)
      calcpass()
  $("#main").append plus

secretstr = ->
  [0...qas.length].map (i) ->
    qas[i]['question'] + qas[i]['answers'][answer[i]]
  .join ''

calcpass = ->
  # newpass = Crypt.crypt $('#seed').val(), secretstr()
  newpass = crypt.crypt $('#seed').val(), secretstr()
  $('#pass').val newpass

calcseed = ->
  # newseed = Crypt.crypt $('#pass').val(), secretstr()
  newseed = crypt.crypt $('#pass').val(), secretstr()
  $('#seed').val newseed
  data['seed'] = newseed

sendfile = (files) ->
  file = files[0]
  fileReader = new FileReader()
  fileReader.onload = (event) ->
    # event.target.result に読み込んだファイルの内容が入っています.
    # ドラッグ＆ドロップでファイルアップロードする場合は result の内容を Ajax でサーバに送信しましょう!
    json = event.target.result
    $("#main").children().remove()
    data = JSON.parse json
    qas = data['qas']
    maindiv()
    calcpass()
  fileReader.readAsText file
  false

$ ->
  $('#seed').keyup (e) ->
    data['seed'] = $('#seed').val()
    calcpass()
  $('#pass').keyup (e) ->
    calcseed()
  $("#save").click ->
    $.ajax
	    type: "POST"
	    async: true
	    url: "/#{name}/__write"
	    data: "data=#{JSON.stringify(data)}"

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

