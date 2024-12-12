json.extract! uploaded_image, :id, :title, :created_at, :updated_at
json.url uploaded_image_url(uploaded_image, format: :json)
