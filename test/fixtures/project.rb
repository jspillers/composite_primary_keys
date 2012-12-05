class Project < ActiveRecord::Base

  attr_accessible :project_id, :account_id, :name, :bugs_attributes

  self.primary_keys = :project_id, :account_id

  has_many :bugs

  accepts_nested_attributes_for :bugs, allow_destroy: true
end
