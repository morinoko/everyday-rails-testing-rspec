require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with a first name, last name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # Shoulda version
  it { is_expected.to validate_presence_of :first_name }

  # Long version
  xit "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # Shoulda version
  it { is_expected.to validate_presence_of :last_name }

  # Long version
  xit "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # Shoulda version
  it { is_expected.to validate_presence_of :email }

  # Long version
  xit "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # Shoulda version
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  # Long version
  xit "is invalid without a duplicate email address" do
    user = FactoryBot.create(:user, email: "joe@example.com")
    other_user = FactoryBot.build(:user, email: "joe@example.com")
    other_user.valid?
    expect(other_user.errors[:email]).to include("has already been taken")
  end

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "Joe", last_name: "Tester")
    expect(user.name).to eq("Joe Tester")
  end

  # Tests can also be written tersly, with `subject` and `is_expected`:
  subject(:user) { FactoryBot.build(:user) } # can be reused with other test examples
  it { is_expected.to satisfy { |user| user.name == "Felice Forby"} }
end
