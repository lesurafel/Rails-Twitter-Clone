class AddUserIdToTweet < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :tweets, :user #add_column :tweets, :user_id
  end
end
