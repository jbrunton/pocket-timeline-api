class Rating < ApplicationRecord
  validates_presence_of :normalized_score, :level

  belongs_to :timeline
  belongs_to :user

  default_scope { order(created_at: :desc) }
  scope :active, -> { where(active: true) }

  def self.aggregate(user)
    Timeline.all.map do |timeline|
      [1, 2, 3].map do |level|
        normalized_score = user.ratings.active
            .where(timeline: timeline, level: level)
            .average(:normalized_score)
        unlocked = level == 1 || begin
          max_level = user.ratings
              .where(timeline: timeline)
              .where('normalized_score >= ?', 0.7)
              .maximum(:level)
          !max_level.nil? && level <= max_level + 1 # i.e. if the max completed level is 1, then 2 is unlocked
        end
        {
            timeline_id: timeline.id,
            level: level,
            normalized_score: normalized_score,
            unlocked: unlocked
        }
      end
    end
  end

  after_create :deactivate_old_entries

  private

  def deactivate_old_entries
    ratings = user.ratings.active.where(timeline: timeline).drop(5)
    ratings.each do |rating|
      rating.active = false
      rating.save
    end
  end
end
