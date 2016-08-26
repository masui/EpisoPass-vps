#
# Facebookなどのログイン画面でEpisoPassを呼び出すブラウザ拡張機能
# ChromeでもFirefoxでも使えるはず
#

$ ->
  passelement = []
  idelement = null
  seed = ''
  
  if location.href.match /facebook.com/ # OK
    passelement = $('#pass')
    idelement = $('#email')
    seed = 'Facebook123456'
  if location.href.match /amazon/ # OK
    passelement = $('#ap_password')
    idelement = $('#ap_email')
    seed = 'Amazon123456'
  if location.href.match /twitter.com/
    idelement = $('.LoginForm-username').children()
    passelement = $('.LoginForm-password').children()
    seed = 'Twitter123456'

  if idelement && passelement && passelement[0] != undefined && passelement.val() == ''
    passelement.on 'click', ->
      if !window.clicked
        id = idelement.val()
        id = 'masui' if !id || id == ''

        div = $('<div>')
          .css 'position','absolute'
          .css 'left','200px'
          .css 'top','250px'
          .css 'width','400px'
          .css 'height','250px'
          .css 'background-color','#ddd'
          .css 'border-radius','5px'
          .css 'z-index','100' # 最前面に
          .attr 'id','episopass'
        $('body').append div

        browser = window.navigator.userAgent.toLowerCase()
        
        # Chromeだと何故かgetJSONがXMLHttpRequestエラーになる
        # Firefoxだとこれで大丈夫
        if browser.indexOf "firefox" > -1
          $.getJSON "http://episopass.com/#{id}.json", (data) ->
            exports.run data,id,seed,passelement

        # Chromeの場合こちらなら大丈夫 httpsでなきゃ駄目!
        if browser.indexOf "chrome" > -1
          xhr = new XMLHttpRequest();
          xhr.open("GET", "https://episopass.com/#{id}.json", true);
          xhr.onreadystatechange = ->
            if xhr.readyState == 4
              data = JSON.parse xhr.responseText
              exports.run data,id,seed,passelement
          xhr.send()

      window.clicked = true
