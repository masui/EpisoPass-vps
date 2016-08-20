# -*- coding: utf-8 -*-
#
# Gyazz/EpisoPassDataの例を展開する
#

require 'gyazz'

questions = []

wiki = Gyazz.wiki('EpisoPassData')
wiki.pages.each do |page|
  page.text.split(/\n/).each { |line|
    if line =~ /^=(.*)$/ then
      s = $1.sub(/\?$/,'')
      questions << s
    end
  }
end

s = "(" + questions.join('|') + ")"

require 're_expand'
puts s.expand

