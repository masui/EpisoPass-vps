# -*- coding: utf-8 -*-
require 're_expand'

time = "(昔|(子供|小学生|中学生)のころ)"
freq = "(よく行ってた|行ったことがある|たまに行った)"
shops = "(本屋|床屋|散髪屋)"
shopevent = "#{freq}#{shops}"

s = "#{time}#{shopevent}"

puts s.expand

