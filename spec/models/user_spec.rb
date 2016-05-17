require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: "Jeremy",
      last_name: "Gunter",
      email: "jeremy@example.com",
      password: "treehouse1234",
      password_confirmation: "treehouse1234"
    }
  }

  context "relationships" do
    it { should have_many(:todo_lists)}

  end

  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires the user to have an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires the user email to be unique" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitve)" do
      user.email = "JEREMYG123@EXAMPLE.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email" do
      user.email = "JeReMy"
      expect(user).to_not be_valid
    end

  end

  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "JEREMYG123@EXAMPLE.COM"))
      expect{ user.downcase_email }.to change{ user.email }.
        from("JEREMYG123@EXAMPLE.COM").
        to("jeremyg123@example.com")
    end

    it "downcases an email before saving it" do
      user = User.new(valid_attributes)
      user.email = "JEREMYG123@EXAMPLE.COM"
      expect(user.save).to be true
      expect(user.email).to eq("jeremyg123@example.com")
    end

  end
end
