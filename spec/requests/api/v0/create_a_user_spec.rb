require "rails_helper"

RSpec.describe "User Registration" do
  describe "happy path" do
    it "creates a user and returns an api key" do
      post "/api/v0/users", params: {email: "test_email@test.com", password: "password", password_confirmation: "password"}, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)
      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to eq("users")
      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to be_a(Hash)
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      expect(user[:data][:attributes]).to_not have_key(:password)
      expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
    end

    it "returns an error if passwords don't match" do
      post "/api/v0/users", params: {email: "test_email@test.com", password: "password", password_confirmation: "assword"}, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to be_a(String)
      expect(error[:error]).to eq("Password confirmation doesn't match Password and Password confirmation doesn't match Password")
    end

    it "returns an error if email is already taken" do
      user_1 = User.create!(email: "taken@liamneeson.com", password: "password", password_confirmation: "password")

      post "/api/v0/users", params: {email: "taken@liamneeson.com", password: "password", password_confirmation: "password"}, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to be_a(String)
      expect(error[:error]).to eq("Email has already been taken")
    end

    it "returns an error if email is missing" do
      post "/api/v0/users", params: {password: "password", password_confirmation: "password"}, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to be_a(String)
      expect(error[:error]).to eq("Email can't be blank")
    end
  end
end