require 'rails_helper'

RSpec.feature 'Editing exercise' do

  before do
    @john = create(:user)
    @exercise_one = @john.exercises.create(duration_in_min: 45,
                                           workout: 'Pushup',
                                           workout_date: Date.today)

    login_as(@john)
  end

  scenario 'with valid data succeeds' do
    visit '/'
    click_link 'My Lounge'

    path = "/users/#{@john.id}/exercises/#{@exercise_one.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click

    fill_in 'Duration', with: 60
    click_button 'Update Exercise'

    expect(page).to have_content('Exercise has been updated')
    expect(page).to have_content(60)
    expect(page).not_to have_content(45)
  end
end
