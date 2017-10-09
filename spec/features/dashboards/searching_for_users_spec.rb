require 'rails_helper'

RSpec.feature 'Searching for user' do
  before do 
    @john = create(:user)
    @sarah = create(:user_two)
  end

  scenario 'with existing name returns all those users' do
    visit '/'

    fill_in 'search_name', with: 'Doe'
    click_button 'Search'

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    expect(current_path).to eq('/dashboards/search')
  end
end
