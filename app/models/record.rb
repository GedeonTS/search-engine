class Record < ApplicationRecord
    belongs_to :user, class_name: 'User',foreign_key: 'user_id'

    validates :name, presence: true, length: { in: 3..255 }
    validates :user_id, presence: true
end