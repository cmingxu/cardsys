class DepartmentPower < ActiveRecord::Base

  belongs_to :department
  belongs_to :power
  #default_scope where({:catena_id => current_catena.id})

  before_create :set_catena_id

  def set_catena_id
    self.catena_id = current_catena.id
  end
end
