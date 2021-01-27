module BlocksHelper
  def block_type_to_string(block_type)
    Block::BLOCK_TYPES[block_type.to_sym]
  end

  def first_block(block)
    block.order == 1
  end

  def last_block(block)
    block.order == block.day.blocks.length
  end

end
