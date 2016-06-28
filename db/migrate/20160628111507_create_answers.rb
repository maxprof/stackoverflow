class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.text :text
      t.integer :positive_vote
      t.integer :negative_vote

      t.timestamps null: false
    end
  end
end
