class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, limit: 30, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
