# -*- coding: utf-8 -*-

require 'rubygems'
require 'config'
require 'digest/md5'
require 'json'

def md5(s)
   Digest::MD5.new.hexdigest(s.to_s).to_s
end

def datafile(name)
  "#{FILEROOT}/#{md5(name)}"
end

def readdata(name)
  file = datafile(name)
  result = nil
  if File.exist?(file) then
    # result = JSON.parse(File.read(file))
    result = File.read(file)
  end
  result
end

def writedata(name,data)
  file = datafile(name)
  File.open(file,"w"){ |f|
    # f.print data.to_json
    f.print data
  }
end

def log(name,data)
  logfile = "#{FILEROOT}/log"
  File.open(logfile,"a"){ |f|
    f.puts "----------"
    f.puts name
    f.puts Time.now
    f.puts data
  }
end

if $0 == __FILE__
  require 'test/unit'
  $test = true
end

if defined?($test) && $test
  class DataTest < Test::Unit::TestCase
    def test_1
      name = ".testdata"
      s = datafile(name)
      assert_equal s.class, String
      assert s. =~ /\/[0-9a-f]{32}/
    end

    def test_2
      name = ".testdata"
      data = [1,2,3,4]
      writedata(name,data.to_json)
      d = JSON.parse(readdata(name))
      assert d.length == 4
    end

    def test_3
      name = ".testdata"
      data = ["abc", "def", "ghi"]
      writedata(name,data.to_json)
      d = JSON.parse(readdata(name))
      assert d[1] == "def"
    end

    def test_4
      name = ".xxxxxx"
      d = readdata(name)
      assert d.nil?
    end
  end
end



