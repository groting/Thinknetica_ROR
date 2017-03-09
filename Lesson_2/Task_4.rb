vowels = %w(a e y u i o)
num = 1

vowels_hash = {}

letters = "a".."z"

letters.each.with_index {|letter, index| vowels_hash[letter] = index+1 if vowels.include?(letter)}

puts vowels_hash