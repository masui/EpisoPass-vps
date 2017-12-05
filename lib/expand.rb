# -*- coding: utf-8 -*-
#
# EpisoDASデータをもとに単一HTMLを生成
#
# % ruby expand.rb Amazon_masui {seed} > Amazon.html
#
require 'erb'
require 'uri'
require "base64"

def get_file(file)
  File.read "/home/masui/EpisoPass/public#{file}"
end

def expand_js(js)
  '<script type="text/javascript">' + js + '</script>'
end

def expand
  name = @name
  seed = if @seed then "'#{@seed}'" else 'null' end

  # Data URI schemeで背景画像を作成
  bg_image =    get_file('/images/exclusive_paper.gif')
  bg_encoded =  Base64.encode64(bg_image).gsub("\n",'')

  fav_image =   get_file('/images/favicon.png')
  fav_encoded = Base64.encode64(fav_image).gsub("\n",'')

  data_json = readdata(@name)

  jquery_js =   get_file('/javascripts/jquery.js')
  episodas_js = get_file('/javascripts/episodas.js')
  md5_js =      get_file('/javascripts/md5.js')
  crypt_js =    get_file('/javascripts/crypt.js')

  ERB.new(<<EOF).result(binding)
<!--
  name: <%= name %>
  seed: <%= seed %>
  data: <%= data_json %>
  -->
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="full-screen" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="EpisoPass">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

    <link rel="icon" type="image/png" href="data:image/png;base64,<%= fav_encoded %>">
    <title><%= @name %></title>
    <style type="text/css">
    body {
        background-image: url("data:image/gif;base64,<%= bg_encoded %>");
    }
    div {
      font-family: sans-serif
    }
    span {
      font-family: sans-serif
    }
    </style>

    <script type="text/javascript">
    const data = <%= data_json %>;
    const name = '<%= name %>';
    const seed = <%= seed %> ? <%= seed %> : data['seed'];
    </script>
    <%= expand_js(jquery_js) %>
    <%= expand_js(episodas_js) %>
    <%= expand_js(md5_js) %>
    <%= expand_js(crypt_js) %>
  </head>
  <body>
  </body>
</html>
EOF

end
