class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :question_tags
  has_many :tags, through: :question_tags
  acts_as_votable
  delegate :login, :email, :avatar, :to => :user, :prefix => true
  validates :title, presence: true
  validates :description, presence: true
  # validates :user_id, presence: true

  def self.latest
    Question.order(:updated_at).last
  end
end
