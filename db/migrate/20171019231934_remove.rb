class Remove < ActiveRecord::Migration[5.1]
  def change
    remove_column :conversations, :sender_id, :integer
    remove_column :conversations, :recipient_id, :integer

  end
end
