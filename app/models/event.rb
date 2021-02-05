class Event < ApplicationRecord
  has_many :days

  validates :name, presence: true
  validates :end_time, presence: true
  validates :start_time, presence: true

  def self.upcoming
    where('start_time > ?', Time.now)
  end

  def self.past
    where('end_time < ?', Time.now)
  end

  def self.current
    where('start_time < ?', Time.now).
    where('end_time > ?', Time.now)
  end

end
