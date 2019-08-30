require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  # set up test data for ALL test in the file if not using let
  # before do
  #   @user = FactoryBot.create(:user)
  #   @project = FactoryBot.create(:project, owner: @user)
  # end

  # validation tests
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note",
      user: user,
      project: project
    )

    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = FactoryBot.build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")  
  end

  it { is_expected.to have_attached_file(:attachment) }

  # Delegating user name to user
  # Regular version
  it "delegates name to the user who created it" do
    user = FactoryBot.create(:user, first_name: "Fake", last_name: "User")
    note = Note.new(user: user)
    expect(note.user_name).to eq "Fake User"
  end

  # Mocked and stubbed version
  it "delegates name to the user who created it" do
    # user = double("user", name: "Fake User")
    # Verified double:
    user = instance_double("User", name: "Fake User")
    
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq "Fake User"
  end

  # search test
  describe "search message for a term" do

    # need to use let! or else all notes won't be created
    # may be better off using a before block...
    let!(:note1) { 
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the first note."
      )
    }

    let!(:note2) { 
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the second note."
      )
    }

    let!(:note3) { 
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "First, preheat the oven."
      )
    }

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(note1, note3)
        expect(Note.count).to eq 3
      end
    end

    context "when no matches are found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end
end
