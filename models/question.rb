class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :content, presence: true, length: { minimum: 5 }
end
