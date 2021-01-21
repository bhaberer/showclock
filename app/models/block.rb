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

end
