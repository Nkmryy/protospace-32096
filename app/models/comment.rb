class Comment < ApplicationRecord
  validates :text, presence: true
  
  belongs_to :prototype
  belongs_to :user
end
