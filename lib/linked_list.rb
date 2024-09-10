require_relative 'node'
require 'pry-byebug'

class Linked_List
  attr_accessor :head

  def initialize
    self.head = nil
  end

  def append(key, value)
    if head.nil?
      self.head = Node.new(key, value, nil)
    elsif head.next_node.nil?
      head.next_node = Node.new(key, value, nil)
    else
      temp_node = head
      temp_node = temp_node.next_node until temp_node.next_node.nil?
      temp_node.next_node = Node.new(key, value, nil)
    end
  end

  def prepend(key, value)
    self.head = if head.nil?
                  Node.new(key, value, nil)
                else
                  Node.new(key, value, head)
                end
  end

  def size
    return 0 if head.nil?

    temp_node = head
    count = 1
    until temp_node.next_node.nil?
      count += 1
      temp_node = temp_node.next_node
    end
    count
  end

  def tail
    return nil if head.nil?

    temp_node = head
    temp_node = temp_node.next_node until temp_node.next_node.nil?
    temp_node
  end

  def at(index)
    return nil if head.nil?

    temp_node = head
    count = 0
    until count == index
      count += 1
      return nil if temp_node.next_node.nil?

      temp_node = temp_node.next_node
    end
    temp_node
  end

  def pop
    return nil if head.nil?

    temp_node = head
    temp_node = temp_node.next_node until temp_node.next_node.next_node.nil?
    temp_node.next_node = nil
  end

  def remove(key)
    deleted_entry = at(find(key))
    return nil if deleted_entry.nil?

    if !at(find(deleted_entry.key) - 1).nil? && !at(find(deleted_entry.key) + 1).nil?
      before_node = at(find(deleted_entry.key) - 1)
      after_node = at(find(deleted_entry.key) + 1)

      before_node.next_node = after_node
      deleted_entry.next_node = nil
    elsif at(find(deleted_entry.key) - 1).nil?
      self.head = deleted_entry.next_node
      deleted_entry.next_node = nil
    elsif at(find(deleted_entry.key) + 1).nil?
      before_node.next_node = nil
    end
    deleted_entry
  end

  def contains?(key)
    return false if head.nil?

    temp_node = head
    return true if temp_node.key == key

    until temp_node.next_node.nil?
      temp_node = temp_node.next_node
      return true if temp_node.key == key
    end
    false
  end

  def find_value(key)
    return nil if head.nil?

    temp_node = head
    return temp_node.value if temp_node.key == key

    until temp_node.next_node.nil?
      temp_node = temp_node.next_node
      return temp_node.value if temp_node.key == key
    end
    nil
  end

  def find(key)
    return nil if head.nil?

    temp_node = head
    return 0 if temp_node.key == key

    count = 0
    until temp_node.next_node.nil?

      return count if temp_node.key == key

      temp_node = temp_node.next_node
      count += 1
    end
    nil
  end

  def to_s
    return nil if head.nil?

    temp_node = head
    until temp_node.nil?
      print "(#{temp_node.key}: #{temp_node.value}) -> "
      temp_node = temp_node.next_node
    end
    puts ' nil'
  end
end
