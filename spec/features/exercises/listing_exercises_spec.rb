require 'rails_helper'

RSpec.feature 'Listing exercises' do
  before do
    @john = create(:user)
    @sarah = create(:sarah)
    login_as(@john)

    @exercise_one = @john.exercises.create(duration_in_min: 70,
                                           workout: 'Pushup',
                                           workout_date: Date.today)
    @exercise_two = @john.exercises.create(duration_in_min: 60,
                                           workout: 'Bench presss',
                                           workout_date: 2.days.ago)
    @exercise_three = @john.exercises.create(duration_in_min: 90,
                                             workout: 'squat',
                                             workout_date: 8.days.ago)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows user's workout for last 7 days" do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content(@exercise_one.duration_in_min)
    expect(page).to have_content(@exercise_one.workout)
    expect(page).to have_content(@exercise_one.workout_date)

    expect(page).to have_content(@exercise_two.duration_in_min)
    expect(page).to have_content(@exercise_two.workout)
    expect(page).to have_content(@exercise_two.workout_date)

    expect(page).not_to have_content(@exercise_three.duration_in_min)
    expect(page).not_to have_content(@exercise_three.workout)
    expect(page).not_to have_content(@exercise_three.workout_date)
  end

  scenario "shows no workout if none is created" do
    @john.exercises.delete_all

    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content('No Workouts yet')
  end

  scenario "shows list of user's friends" do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content('My Friends')
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link('Unfollow')
  end
end

