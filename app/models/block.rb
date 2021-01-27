class Block < ApplicationRecord
  BLOCK_TYPES = {
    muscial_act: "Muscial Act",
    setup: "Setup",
    sound_check: "Sound Check"
  }

  belongs_to :day
  delegate :event, to: :day

  validates :day, presence: true
  validates :name, presence: true
  validates :block_type, inclusion: {in: Block::BLOCK_TYPES.keys.map(&:to_s)},
                         presence: true
  validates :order, presence: true,
                    uniqueness: true,
                    inclusion: { in: 1..2000 }
  validates :duration, numericality: true,
                       presence: true,
                       inclusion: {
                         in: 5..120,
                         message: "must be between 5 and 120 minutes"
                       }


  def self.types_for_select
    block_types = []
    Block::BLOCK_TYPES.each do |key, value|
      block_types << [value, key]
    end
    block_types
  end

  def move_later!
    # Return if this is the last block of the day
    return if self.order == self.day.blocks.length

    later_block = Block.where(day: self.day, order: self.order + 1).first

    # Return if there's no later block found
    return unless later_block

    later_block.update_attribute(:order, self.order)
    self.update_attribute(:order, self.order + 1)

    return self
  end

  def move_earlier!
    # Return if this is the first block of the day
    return if self.order == 1

    earlier_order = self.order - 1
    earlier_block = Block.where(day: self.day, order: earlier_order).first

    # Return if there's no earlier block found
    return unless earlier_block

    earlier_block.update_attribute(:order, self.order)
    self.update_attribute(:order, earlier_order)

    return self.save && earlier_block.save
  end
end
