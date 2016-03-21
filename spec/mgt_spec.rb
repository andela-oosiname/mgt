require "spec_helper"

describe "Todolist App" do
  include Rack::Test::Methods

  it "returns a list of all my todos" do
    get "/todo"
    expect(last_response).to be_ok
  end

  # it "returns first item in my todolist" do
  #   get '/todo/first'
  #   expect(last_response).to be_ok
  #   expect(last_response.body).to eq("Write a book")
  # end

  # it "can respond to post request" do
  #   post '/todo'
  #   expect(last_response).to be_ok
  #   expect(last_response.body).to eq("Post go swimming")
  # end

  # it "can respond to put request" do
  #   put '/todo'
  #   expect(last_response).to be_ok
  #   expect(last_response.body).to eq("Put Write a book")
  # end

  # it "can respond to delete request" do
  #   delete '/todo'
  #   expect(last_response).to be_ok
  #   expect(last_response.body).to eq("Delete Write a book")
  # end
end

describe Mgt do
  it "has a version number" do
    expect(Mgt::VERSION).not_to be nil
  end
end
