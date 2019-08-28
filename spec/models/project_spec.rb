require 'rails_helper'

RSpec.describe Project, type: :model do
  xit "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

  describe "duplicate project names" do

    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, owner: @user, name: "Rails app")
    end

    context "within a single user" do
      it "does not allow duplicate project names" do
        new_project = FactoryBot.build(:project, owner: @user, name: "Rails app")

        new_project.valid?
        expect(new_project.errors[:name]).to include("has already been taken")
      end
    end

    context "across different users" do
      it "does allow duplicate project names" do
        another_user = FactoryBot.create(:user)
        another_users_project = FactoryBot.build(:project, owner: another_user, name: "Rails app")

        expect(another_users_project).to be_valid
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
