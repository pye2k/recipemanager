class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :chef
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 20 }
end