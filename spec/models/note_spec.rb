require 'rails_helper'

RSpec.describe Note, type: :model do

  # set up test data for ALL test in the file
  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: @user)
  end

  # validation tests
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note",
      user: @user,
      project: @project
    )

    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = FactoryBot.build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")  
  end

  # search test
  describe "search message for a term" do

    # set up extra test data for all tests in this describe block
    before do
      @note1 = @project.notes.create(
        message: "This is the first note.",
        user: @user
      )

      @note2 = @project.notes.create(
        message: "This is the second note.",
        user: @user
      )

      @note3 = @project.notes.create(
        message: "First, preheat the oven.",
        user: @user
      )
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    context "when no matches are found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end
