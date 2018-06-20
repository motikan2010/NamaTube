class VideoRail < ApplicationRecord
  has_many :videos, dependent: :destroy
  has_many :tags, :through => :videos
end
