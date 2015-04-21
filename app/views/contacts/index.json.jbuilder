json.array!(@contacts) do |contact|
  json.extract! contact, :id, :sex, :first_name, :last_name, :company, :email, :is_broker, :is_charterer, :is_owner, :region, :size, :comment
  json.url contact_url(contact, format: :json)
end
