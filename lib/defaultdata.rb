# -*- coding: utf-8 -*-

def defaultdata
  {
    :seed => 'defaultseed',
    :questions => [
                   ["私の名前は?", ["masui", "toshiyuki", "madoka"]],
                   ["私の年齢は?", ["10", "20", "30"]],
               ]
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

