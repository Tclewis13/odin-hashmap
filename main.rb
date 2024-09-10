require_relative 'lib/hashmap'
require 'pry-byebug'

test = Hashmap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

# hash_map.print_hashmap
puts test.get('apple')
puts test.has?('farts')
puts test.has?('lion')
# puts hash_map.length
puts test.remove('kite').to_str
# puts hash_map.length
puts test.remove('kite')
test.print_hashmap
# puts hash_map.length
puts test.keys
puts test.values
puts test.entries
test.clear
# puts hash_map.length
test.print_hashmap
