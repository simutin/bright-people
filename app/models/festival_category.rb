class FestivalCategory < ActiveRecord::Base
  include Hierarchy
  attr_accessible :title, :path

  before_destroy :destroy_children

  has_many :gallery_photos

  validates :title, presence: true, uniqueness: true

  scope :top, where(:path => "")

  def photos
    if top_level?
      photos = gallery_photos
      children.each do |child|
        photos += child.gallery_photos
      end
      photos
    else
      gallery_photos
    end
  end

  def self.all_photos
    top.map(&:photos).flatten
  end

  private
  def destroy_children
    if top_level?
      children.map &:destroy
    end
  end
end
