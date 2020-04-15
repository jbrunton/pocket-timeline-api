class Event < ApplicationRecord
  belongs_to :timeline
  has_and_belongs_to_many :categories

  before_save :check_categories

  private

  def check_categories
    unless self.categories.any?
      misc_category = timeline.categories.find_or_create_by(name: 'Miscellaneous')
      self.categories = [misc_category]
    end
  end
end
