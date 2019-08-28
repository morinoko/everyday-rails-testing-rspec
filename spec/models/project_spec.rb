require 'rails_helper'

RSpec.describe Project, type: :model do
  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

  describe "duplicate project names" do

    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, owner: @user, name: "Test Project")
    end

    context "within a single user" do
      it "does not allow duplicate project" do
        new_project = FactoryBot.build(:project, owner: @user, name: "Test Project")
        
        new_project.valid?
        expect(new_project.errors[:name]).to include("has already been taken")
      end
    end

    context "across different users" do
      it "allows two projects to have the same name" do
        other_user = FactoryBot.create(:user)
        other_project = FactoryBot.create(:project, owner: other_user, name: "Test Project")

        expect(other_project).to be_valid
      end
    end
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end
end
