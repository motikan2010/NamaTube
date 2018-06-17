class Video < ApplicationRecord
  has_many :video_tags, dependent: :destroy
  has_many :tags, :through => :video_tags

  accepts_nested_attributes_for :video_tags, allow_destroy: true
end
