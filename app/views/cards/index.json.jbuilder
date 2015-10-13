json.array!(@cards) do |card|
  json.extract! card, :id, :new, :create, :update, :destroy
  json.url card_url(card, format: :json)
end
