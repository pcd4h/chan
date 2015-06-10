class EnumValue < ActiveRecord::Base
  belongs_to :form_property

  validates :enumvalid, presence: true
  validates :name, presence: true
end
