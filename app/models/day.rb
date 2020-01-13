class Day < ApplicationRecord
  belongs_to :event
  has_many :blocks

  validates :event, presence: true

end
