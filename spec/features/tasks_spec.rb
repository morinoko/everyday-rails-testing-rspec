require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "user toggles a task", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user, name: "RSpec Tutorial")
    task = project.tasks.create!(name: "Finish RSpec tutorial")

    sign_in_as(user)

    click_link "RSpec Tutorial"
    check "Finish RSpec tutorial"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed

    uncheck "Finish RSpec tutorial"

    expect(page).to_not have_css "label#task_#{task.id}.completed"
    expect(task.reload).to_not be_completed
  end
end
