class Post < ApplicationRecord
  validates_presence_of :content
  belongs_to :user

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id ).first
  end

  has_many :collections, :dependent => :destroy
  has_many :collection_users, :through => :collections, :source => :user

  def find_collection(user)
    self.collections.where( :user_id => user.id ).first
  end

end
