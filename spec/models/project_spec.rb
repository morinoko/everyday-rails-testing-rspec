require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names within a single user" do
    user = User.create(
      first_name:  "Joe",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    user.projects.create(
      name: "Test Project"
    )

    new_project = user.projects.build(
      name: "Test Project"
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two different users to have the same project name" do
    user = User.create(
      first_name:  "Joe",
      last_name:  "Tester",
      email:      "joe-tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    user.projects.create(
      name: "Test Project"
    )

    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "jane-tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    other_project = other_user.projects.create(
      name: "Test Project"
    )

    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project_due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project_due_tomorrow)
      expect(project).to_not be_late
    end
  end
end
