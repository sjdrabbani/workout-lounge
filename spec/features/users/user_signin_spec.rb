require 'rails_helper'

RSpec.feature do 'User sign in' do
  before do
    let(:john) { User.create!(email: 'joe@example.com', password: 'password') }
  end

  scenario 'with valid credentials' do
    visit '/'
    
    click_link 'Sign in'
    fill_in 'Email', with: john.email
    fill_in 'Password', with: john.password
    click_button 'Log in'

    expect(page).to have_content('Signed up successfully')
    expect(page).to have_content("Signed up as #{john.email}")
end

