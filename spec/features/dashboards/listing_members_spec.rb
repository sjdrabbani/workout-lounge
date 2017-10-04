require 'rails_helper'

RSpec.feature 'Listing members' do
  before do
    @john = User.create(firstname: 'John',
                        last_name: 'Doe',
                        email: 'john@example.com',
                        password: 'password')
    @sarah = User.create(firstname: 'Sarah',
                        last_name: 'Jones',
                        email: 'sarah@example.com',
                        password: 'password')

  end

  scenario 'shows a list of registered members' do
    visit '/'

    expect(page).to have_content('List of members')
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
  end
end
