class Day < ApplicationRecord
  belongs_to :event
  has_many :blocks

  validates :event, presence: true
  validates :name,  presence: true,
                    inclusion: { in: Date::DAYNAMES }
  validates :start_time,  presence: true

  def day_duration
    blocks.map(&:duration).sum
  end

  def end_time
    start_time + day_duration.minutes
  end

  def in_progress?
    !pre_show? && !post_show?
  end

  def pre_show?
    start_time > DateTime.now.utc
  end

  def post_show?
    DateTime.now.utc > end_time
  end

  def current_block
    return unless blocks.present?
    return unless in_progress?
    blocks.each do |block|
      if block.start_time < DateTime.now.utc && DateTime.now.utc < block.end_time
        return block
      end
    end
  end

end
