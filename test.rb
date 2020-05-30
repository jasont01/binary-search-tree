require './tree.rb'

#arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
#p test = Tree.new(arr)

puts "\n1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)"
arr = Array.new(15) { rand(1..100)}
test = Tree.new(arr)
p test

puts "\n2. Confirm that the tree is balanced by calling `#balanced?`"
p test.balanced?

puts "\n3. Print out all elements in level, pre, post, and in order"
puts "level order: #{test.level_order}"
puts "preorder: #{test.preorder}"
puts "inorder: #{test.inorder}"
puts "postorder: #{test.postorder}"

puts "\n4. try to unbalance the tree by adding several numbers > 100"

rand(2..10).times do
  random = rand(101..999)
  test.insert(random)
  puts "#{random} added!"
end

puts "\n5. Confirm that the tree is unbalanced by calling `#balanced?`"
p test.balanced?

puts "\n6. Balance the tree by calling `#rebalance!`"
test.rebalance!
p test

puts "\n7. Confirm that the tree is balanced by calling `#balanced?`"
p test.balanced?

puts "\n8. Print out all elements in level, pre, post, and in order"
puts "level order: #{test.level_order}"
puts "preorder: #{test.preorder}"
puts "inorder: #{test.inorder}"
puts "postorder: #{test.postorder}"