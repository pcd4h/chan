class FormProperty < ActiveRecord::Base
  belongs_to :task

  validates :formproptype, presence: true

  has_many :enum_values, dependent: :destroy
  accepts_nested_attributes_for :enum_values, :allow_destroy => true
end
