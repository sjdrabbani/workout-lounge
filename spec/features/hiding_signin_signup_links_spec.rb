require 'rails_helper'

RSpec.feature 'Hiding sign in sign up link' do
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
  end

  scenario 'upon successful sign in' do
    visit '/'

    click_link 'Sign in'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Log in'

    expect(page).to have_link('Sign out')
    expect(page).not_to have_link('Sign up')
    expect(page).not_to have_link('Sign in')
  end
end

