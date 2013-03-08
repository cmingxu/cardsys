class AddConfigToClient < ActiveRecord::Migration
  def change
    add_column :clients, :config, :text
  end
end
