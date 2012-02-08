require 'ipaddr/tree/version'

class IPAddr
  module Tree
    def parent
      mask prefix_length - 1 if prefix_length > 0
    end

    def next_sibling
      dup.set(@addr + 2 ** block_length) if @addr < (2 ** family_length) - 1
    end

    def previous_sibling
      dup.set(@addr - 2 ** block_length) if @addr > 0
    end

    def left_child
      mask prefix_length + 1 if block_length > 0
    end

    def right_child
      mask(prefix_length + 1).set(@addr + 2 ** (block_length - 1)) if block_length > 0
    end

    def cidr_notation
      "#{to_s}/#{prefix_length}"
    end

    def prefix_length
      family_length - block_length
    end

    def block_length
      Math.log2(addr_mask(~@mask_addr) + 1).to_i
    end

    def family_length
      ipv4? ? 32 : 128
    end
  end
  include Tree
end