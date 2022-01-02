class AddUserIdToQuestions < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM questions;'
    add_reference :questions, :user, null: false, foreign_key: true
  end

  def down
    remove_reference :questions, :user, foreign_key: true
  end
end
