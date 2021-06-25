json.extract! candidate, :id, :fname, :lname, :email, :angelist, :linkedin, :position_id, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
