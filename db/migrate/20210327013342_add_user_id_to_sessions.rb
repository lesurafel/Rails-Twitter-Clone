class AddUserIdToSessions < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :sessions, :user #add_column :sessions, :user_id
  end
end
