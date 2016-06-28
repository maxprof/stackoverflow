class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :positive_vote
      t.integer :negative_vote
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
