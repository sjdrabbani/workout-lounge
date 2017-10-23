class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_chatroom

  self.per_page =10

  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'
  has_one :room

  def full_name
    [first_name, last_name].join(' ')
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end

  private

  def create_chatroom
    hyphenated_username = self.full_name.split.join('-')
    self.create_room(name: hyphenated_username)
  end
end
