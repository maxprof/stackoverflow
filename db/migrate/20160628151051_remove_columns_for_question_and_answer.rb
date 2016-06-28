class RemoveColumnsForQuestionAndAnswer < ActiveRecord::Migration
  def change
    remove_column :questions, :positive_vote, :integer
    remove_column :questions, :negative_vote, :integer
    remove_column :answers, :positive_vote, :integer
    remove_column :answers, :negative_vote, :integer
    add_column :questions, :visitors, :integer
  end
end
