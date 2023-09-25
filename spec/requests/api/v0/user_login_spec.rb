require "rails_helper"

RSpec.describe "User Login" do
  describe "happy path" do
    it "logs in a user and returns an api key" do
      user1 = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
      
      user_params = {email: "test@test.com", password: "password"}
      post "/api/v0/sessions", params: user_params, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      session = JSON.parse(response.body, symbolize_names: true)
      
      expect(session).to be_a(Hash)
      expect(session).to have_key(:data)
      expect(session[:data]).to be_a(Hash)
      expect(session[:data]).to have_key(:id)
      expect(session[:data][:id]).to be_a(String)
      expect(session[:data]).to have_key(:type)
      expect(session[:data][:type]).to eq("users")
      expect(session[:data]).to have_key(:attributes)
      expect(session[:data][:attributes]).to be_a(Hash)
      expect(session[:data][:attributes]).to have_key(:email)
      expect(session[:data][:attributes][:email]).to be_a(String)
      expect(session[:data][:attributes]).to have_key(:api_key)
      expect(session[:data][:attributes][:api_key]).to be_a(String)
      expect(session[:data][:attributes]).to_not have_key(:password)
      expect(session[:data][:attributes]).to_not have_key(:password_confirmation)
    end
    
    it "returns an error if email is incorrect" do
      user1 = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
      
      user_params = {email: "123", password: "password"}
      post "/api/v0/sessions", params: user_params, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      
      user_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(user_data).to be_a(Hash)
      expect(user_data).to have_key(:error)
      expect(user_data[:error]).to be_a(String)
      expect(user_data[:error]).to eq("Invalid credentials")
    end
    
    it "returns an error if password is incorrect" do
      user1 = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")

      user_params = {email: "test@test.com", password: "123"}
      post "/api/v0/sessions", params: user_params, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data).to be_a(Hash)
      expect(user_data).to have_key(:error)
      expect(user_data[:error]).to be_a(String)
      expect(user_data[:error]).to eq("Invalid credentials")
    end
  end
end