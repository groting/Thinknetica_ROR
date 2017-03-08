vowels = ["a","e","y","u","i","o"]
num = 1

vowels_hash = {}

for letter in "a".."z" do 
  vowels_hash[letter] = num if vowels.include?(letter)
  num += 1
end