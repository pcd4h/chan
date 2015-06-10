class Task < ActiveRecord::Base

  validates :taskid, presence: true
  validates :url, presence: true
  validates :assignee, presence: true
  
  has_many :form_properties, dependent: :destroy
  accepts_nested_attributes_for :form_properties, :allow_destroy => true
end
