# -*- coding: utf-8 -*-

def defaultdata
  {
    :seed => 'defaultseed',
    :qas => [
             {
               :question => "私の名前は?",
               :answers => ["masui", "toshiyuki", "madoka"],
             },
             {
               :question => "私の年齢は?",
               :answers => ["10", "20", "30", "40"],
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

