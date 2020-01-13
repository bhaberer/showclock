class Block < ApplicationRecord
  belongs_to :day

  validates :day, presence: true

end
