class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  acts_as_votable
  delegate :login, :avatar, :to => :user, :prefix => true
end
