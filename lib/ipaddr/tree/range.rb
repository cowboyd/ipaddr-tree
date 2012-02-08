require 'ipaddr/tree'

class IPAddr
  module Tree::Range
    def blocks_until(other)
      other = IPAddr.new(other.to_s) unless other.is_a?(IPAddr)
      return other.blocks_until(self) if other < self
      if self.include? other
        if self.include? other.next_sibling
          self.left_child.blocks_until(other)
        else
          [self]
        end
      elsif self.parent.include? self.next_sibling
        self.parent.blocks_until(other)
      else
        [self] + self.next_sibling.blocks_until(other)
      end
    end
  end
  include Tree::Range
end