class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }, uniqueness: true
end
