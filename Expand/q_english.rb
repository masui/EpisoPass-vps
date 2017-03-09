require 're_expand'

questions = [
  "I injured my (leg|hand|arm|head) at XXXX when I was (a child|very young|at school).",
  "I had an accident at (Mt. XXX|XXX river) when I was (a child|very young|at school).",
  "One of my friends, Mr. XXX, always did bad things to me when I was (a child|very young|at school).",
  "I sent a special letter to Miss XXX, but didn't received any reply from her.",
  "I personally dislike Mr. XXX.",
  "XXX was always complainig about his (health|misfortune).",
  "I found a very special stone at Mt. XXX.",
  "",
]

questions.each { |question|
  question.expand { |s,a|
    puts s
  }
}

