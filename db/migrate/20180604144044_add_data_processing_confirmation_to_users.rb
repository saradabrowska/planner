class AddDataProcessingConfirmationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :data_processing_confirmation, :boolean, default: true
  end
end
