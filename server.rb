require "sinatra"
require "json"
require "csv"
require "./fortune"

require "pry"

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  redirect to("/fortunes/random")
end

get "/fortunes/random.json" do
  content_type :json
  Fortune.sample.to_json
end

get "/fortunes/random" do
  erb :show, locals: { fortune: Fortune.sample }
end

get "/fortunes/:id" do |id|
  fortune = Fortune.read(id)
  erb :show, locals: { fortune: fortune }
end

get "/fortunes" do
  erb :index, locals: { fortunes: Fortune.all }
end

post "/fortunes" do
  unless params[:content].nil? || params[:content].empty?
    Fortune.create(params[:content])
  end
  redirect to("/fortunes")
end


# RESTful JSON interface

get "/api/v1/fortunes.json" do
  fortunes = Fortune.all
  fortunes.map(&:to_json).to_json
end

get "/api/v1/fortunes/random.json" do
  content_type :json
  Fortune.sample.to_json
end

get "/api/v1/fortunes/:id.json" do |id|
  fortune = Fortune.read(id)
  if fortune
    status 200
    fortune.to_json
  else
    status 404
  end
end

post "/api/v1/fortunes.json" do
  unless params[:content].nil? || params[:content].empty?
    # 201 Created, Location: /fortunes/:id
    fortune = Fortune.create(params[:content])

    status 201
    headers "Location" => "/fortunes/#{fortune.id}"
  else
    status 400
  end
end

put "/api/v1/fortunes/:id.json" do |id|
  # 204 No Content, or 404 Not Found if id dne
  fortune = Fortune.read(id)
  if fortune.nil?
    status 404
  else
    Fortune.update(id, params[:content])
    status 204
  end
end

delete "/api/v1/fortunes/:id.json" do |id|
  # 200 OK, or 404 Not Found if id dne
  fortune = Fortune.read(id)
  if fortune.nil?
    status 404
  else
    Fortune.delete(id)
    status 204
  end
end
