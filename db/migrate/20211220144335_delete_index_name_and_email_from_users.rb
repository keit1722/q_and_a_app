class DeleteIndexNameAndEmailFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, %i[name email]
  end
end
