require_relative 'linked_list'
require 'pry-byebug'

class Hashmap
  attr_accessor :size, :hash_array, :length, :load_factor

  def initialize
    self.size = 16
    self.length = 0
    self.hash_array = Array.new(size)
    self.load_factor = 0.8
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % size
  end

  def expand
    self.size = size * 2
    entry_array = entries
    old_length = length
    self.hash_array = []
    self.hash_array = Array.new(size)

    entry_array.each do |entry|
      set(entry[0], entry[1])
    end
    self.length = old_length
  end

  def set(key, value)
    hash_code = hash(key)
    if hash_array[hash_code].nil?
      hash_array[hash_code] = Linked_List.new
      hash_array[hash_code].head = Node.new(key, value, nil)
      self.length += 1
    elsif !hash_array[hash_code].contains?(key)
      hash_array[hash_code].append(key, value)
      self.length += 1
    else
      index = hash_array[hash_code].find(key)
      hash_array[hash_code].at(index).value = value
    end
    expand if length > load_factor * size
  end

  def get(key)
    hash_code = hash(key)
    return nil if hash_array[hash_code].nil?

    hash_array[hash_code].find_value(key)
  end

  def has?(key)
    hash_code = hash(key)
    return false if hash_array[hash_code].nil?

    return true unless hash_array[hash_code].find_value(key).nil?

    false
  end

  def remove(key)
    hash_code = hash(key)
    return nil if hash_array[hash_code].nil?
    return nil unless hash_array[hash_code].contains?(key)

    self.length -= 1
    hash_array[hash_code].remove(key)
  end

  def clear
    hash_array.each do |bucket|
      bucket.head = nil unless bucket.nil?
    end
    self.length = 0
  end

  def keys
    key_array = []
    hash_array.each do |bucket|
      next if bucket.nil?
      next if bucket.head.nil?

      temp_node = bucket.head
      key_array << bucket.head.key
      until temp_node.next_node.nil?
        temp_node = temp_node.next_node
        key_array << temp_node.key
      end
    end
    key_array
  end

  def values
    values_array = []
    hash_array.each do |bucket|
      next if bucket.nil?
      next if bucket.head.nil?

      temp_node = bucket.head
      values_array << bucket.head.value
      until temp_node.next_node.nil?
        temp_node = temp_node.next_node
        values_array << temp_node.value
      end
    end
    values_array
  end

  def entries
    entries_array = []
    hash_array.each do |bucket|
      next if bucket.nil?
      next if bucket.head.nil?

      temp_node = bucket.head
      entries_array << [bucket.head.key, bucket.head.value]
      until temp_node.next_node.nil?
        temp_node = temp_node.next_node
        entries_array << [temp_node.key, temp_node.value]
      end
    end
    entries_array
  end

  def print_hashmap
    hash_array.each do |hash|
      if hash.nil?
        puts 'Empty'
      else
        hash.to_s
      end
    end
  end
end
