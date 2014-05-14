json.array!(@projects) do |project|
  json.extract! project, :id, :title, :length, :content
  json.url project_url(project, format: :json)
end
