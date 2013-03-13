class ChangePower < ActiveRecord::Migration
  def up
    remove_column :powers, :string
    remove_column :powers, :action
    add_column :powers, :path, :string
  end

  def down
    remove_column :powers, :path
    add_column :powers, :string, :string
    add_column :powers, :action, :string
  end
end
