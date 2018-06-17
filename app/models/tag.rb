class Tag < ApplicationRecord
  has_many :video_tags, dependent: :destroy
  has_many :videos, :through => :video_tags
end
