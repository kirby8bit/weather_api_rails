class Indication < ApplicationRecord
  validates :temperature, presence: true
  validates :unit, presence: true
  validates :epochTime, presence: true
end
