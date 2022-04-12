class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :age, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 150 }
end
