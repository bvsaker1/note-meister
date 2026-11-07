class Note < ApplicationRecord
  validates :author, :category, :note, presence: true
end
