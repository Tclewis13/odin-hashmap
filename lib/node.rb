class Node
  attr_accessor :value, :next_node, :key

  def initialize(key = nil, value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
    self.key = key
  end

  def to_str
    str_key = key.nil? ? 'nil' : key
    str_value = value.nil? ? 'nil' : value
    puts "key: #{str_key} value: #{str_value}"
  end
end
