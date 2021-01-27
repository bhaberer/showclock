module BlocksHelper
  def block_type_to_string(block_type)
    Block::BLOCK_TYPES[block_type.to_sym]
  end
end
