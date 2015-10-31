assert = require 'assert'

crypt =  require './crypt.coffee'

seed = "abcdefg"
secret = "asdofasofnaweifnaweaf"

assert seed == crypt.crypt(crypt.crypt(seed, secret), secret)


