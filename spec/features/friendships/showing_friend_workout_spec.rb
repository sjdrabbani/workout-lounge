require 'rails_helper'

RSpec.feature 'Showing Friend Workout' do
  before do
    @john = create(:user)
    @sarah = create(:sarah)

    @exercise_one = @john.exercises.create(duration_in_min: 60,
                                           workout: 'pushup',
                                           workout_date: Date.today)

    @exercise_two = @sarah.exercises.create(duration_in_min: 90,
                                           workout: 'squat',
                                           workout_date: Date.today)

    @following = Friendship.create(user: @john, friend: @sarah)
    login_as(@john)
  end

  scenario "show friend's workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'
    click_link @sarah.full_name

    expect(page).to have_content("#{@sarah.full_name}'s Exercises")
    expect(page).to have_content(@exercise_two.workout)
  end
end
