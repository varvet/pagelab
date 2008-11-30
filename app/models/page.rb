# == Schema Information
# Schema version: 20081130155729
#
# Table name: pages
#
#  id           :integer         not null, primary key
#  slug         :string(255)     not null
#  title        :string(255)     not null
#  body         :text            not null
#  user_id      :integer         not null
#  version      :integer
#  locked_at    :datetime
#  locked_by_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Page < ActiveRecord::Base
  acts_as_versioned
  
  belongs_to :user
  belongs_to :locked_by, :class_name => 'User'
  
  validates_presence_of :slug
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :user_id
  
  validates_uniqueness_of :slug
  validates_uniqueness_of :title
  
  before_validation_on_create :set_slug_from_title
  
  def self.find_or_build_by_slug (slug)
    find_by_slug(slug) || new(:title => slug.underscore.humanize)
  end
  
  def to_param
    slug
  end

protected

  def set_slug_from_title
    self.slug = title.parameterize
  end

end
