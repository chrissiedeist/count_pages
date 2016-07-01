require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)

    expect(user).to be_valid
  end

  it "has an email" do
    user = FactoryGirl.create(
      :user,
      :email => "chrissie3@gmail.com",
      :password => "abcd1234",
    )

    expect(user).to be_valid
    expect(user.email).to eq("chrissie3@gmail.com")
  end
end
