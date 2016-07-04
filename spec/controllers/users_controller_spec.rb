require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:valid_attributes) {
    FactoryGirl.build(:user).attributes
  }
  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end
    end
  end
end
