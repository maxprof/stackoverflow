json.array!(@answers) do |answer|
  json.extract! answer, :id, :user_id, :text, :positive_vote, :negative_vote
  json.url answer_url(answer, format: :json)
end
