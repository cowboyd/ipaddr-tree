require 'ipaddr/tree'

class IPAddr
  module Tree::Range
    def blocks_until(other)
      other = IPAddr.new(other.to_s) unless other.is_a?(IPAddr)
      return other.blocks_until(self) if other < self
      if include? other
        if next_sibling.include? other.next_sibling
          [self]
        elsif left_child && left_child.include?(other)
          left_child.blocks_until(other)
        elsif leaf?
          [self]
        else
          [left_child] + right_child.blocks_until(other)
        end
      elsif parent.include? previous_sibling
        [self] + next_sibling.blocks_until(other)
      else
        parent.blocks_until(other)
      end
    end
  end
  include Tree::Range
end