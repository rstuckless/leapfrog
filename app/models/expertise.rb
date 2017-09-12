require "json"
class Expertise < ApplicationRecord
  belongs_to :skill
  belongs_to :expert
end
