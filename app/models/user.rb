class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :age, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 150 }

    scope :search, -> (name) { where("name like ?", "%#{name.downcase}%") if name.present? }
    scope :older , -> (minage) { where("age > ?", minage) if minage.present? }
    scope :younger, -> (maxage) { where("age < ?", maxage) if maxage.present? }
    scope :ip, -> (ip) { where("ip like ?", ip) if ip.present?}
end
