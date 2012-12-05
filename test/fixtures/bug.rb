class Bug < ActiveRecord::Base

  self.primary_keys = :project_id, :name

  attr_accessible :project_id, :name, :description

  belongs_to :project
end
