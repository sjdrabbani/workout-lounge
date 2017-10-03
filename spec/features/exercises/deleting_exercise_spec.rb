require 'rails_helper'

RSpec.feature 'Deleting exercise' do

  before do
    @john = User.create(email: 'john@example.com', password: 'password')

    @exercise_one = @john.exercises.create(duration_in_min: 45,
                                           workout: 'Pushup',
                                           workout_date: Date.today)

    login_as(@john)
  end

  scenario  do
    visit '/'
    click_link 'My Lounge'

    path = "/users/#{@john.id}/exercises/#{@exercise_one.id}"
    link = ".//a[contains(@href, '#{path}') and .//text()='Delete']"
    find(:xpath, link).click

    expect(page).to have_content('Exercise has been deleted')
  end
end
