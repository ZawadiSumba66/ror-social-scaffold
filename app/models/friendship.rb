class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  # enum status: { confirmed: 'confirmed', pending: 'pending' }
end
