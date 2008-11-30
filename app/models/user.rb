# == Schema Information
# Schema version: 20081130155729
#
# Table name: users
#
#  id           :integer         not null, primary key
#  identity_url :string(255)     not null
#  firstname    :string(255)
#  lastname     :string(255)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base
  has_many :pages
  has_many :page_locks, :class_name => 'Page', :foreign_key => 'locked_by_id'
  
  validates_presence_of   :identity_url
  validates_uniqueness_of :identity_url
  
  validate :normalized_identity_url
  
  def name
    names = [firstname, lastname].compact
    names.join(' ') unless names.empty?
  end
  
  def name= (value)
    self.firstname, self.lastname = value.split(' ', 2) unless value.blank?
  end
  
  def name?
    !name.blank?
  end
  
protected

  def normalized_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url)
  rescue InvalidOpenId
    errors.add(:identity_url, 'is not a valid URL')
  end
  
end
