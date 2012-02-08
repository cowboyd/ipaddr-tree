require 'ipaddr/tree'

class IPAddr
  module Tree::Range
    def blocks_until(other)
      other = IPAddr.new(other.to_s) unless other.is_a?(IPAddr)
      return other.blocks_until(self) if other < self
      if include? other
        if include? other.next_sibling
          left_child.blocks_until(other)
        else
          [self]
        end
      elsif parent.include? next_sibling
        if next_sibling.left_child && next_sibling.left_child.include?(other)
          [self] + next_sibling.left_child.blocks_until(other)
        else
          parent.blocks_until(other)
        end
      else
        [self] + next_sibling.blocks_until(other)
      end
    end
  end
  include Tree::Range
end