json.array!(@questions) do |question|
  json.extract! question, :id, :user_id, :positive_vote, :negative_vote, :title, :description
  json.url question_url(question, format: :json)
end
