# -*- coding: utf-8 -*-

def defaultdata
  {
    :seed => 'seed12345',
    :qas => [
             {
               :question => "小学生のとき好きだったのは?",
               :answers => ["まさこちゃん", "のりこちゃん", "みどりちゃん", "こづえちゃん"],
             },
             {
               # :question => "http://farm1.static.flickr.com/54/121077554_eb0138d019.jpg",
               :question => "https://gyazo.com/756acf45b7456be0a53146732f5a92ca.png",
               :answers => ["物理", "体育", "音楽", "英語", "書道"],
             },
            ],
  }
end

if $0 == __FILE__
  require 'test/unit'
  $test = true
end

if defined?($test) && $test
  class DataTest < Test::Unit::TestCase
    def test_1
      data = defaultdata
      assert_equal data[:seed], 'defaultseed'
    end
  end
end

