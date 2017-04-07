class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :posts
   has_many :likes, :dependent => :destroy
   has_many :liked_posts, :through => :likes, :source => :post

   has_many :collections, :dependent => :destroy
   has_many :collection_posts, :through => :collections, :source => :post


   def display_name
     self.email.split("@").first
   end
end
