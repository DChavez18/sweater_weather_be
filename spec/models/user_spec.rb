require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_confirmation_of :password }
  end

  describe "class methods" do
    describe ".generate_api_key" do
      it "generates an api key for a user" do
        user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")

        expect(user.api_key).to_not be_nil
      end
    end
  end
end
