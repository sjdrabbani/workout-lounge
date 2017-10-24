require 'rails_helper'

RSpec.feature 'Sending a message' do
  before do
    @john = create(:user)
    @sarah = create(:sarah)
    @henry = create(:henry)

    @room_name = @john.full_name.split.join('-')
    @room = Room.create(name: @room_name, user: @john)

    login_as(@john)

    Friendship.create(user: @sarah, friend: @john)
    Friendship.create(user: @henry, friend: @john)
  end

  scenario 'to followers show in chatroom' do
    visit '/'
    click_link 'My Lounge'
    expect(page).to have_content(@room_name)

    fill_in 'message-field', with: 'Hello'
    click_button 'Post'

    expect(page).to have_content('Hello')

    within('#followers') do
      expect(page).to have_link(@sarah.full_name)
      expect(page).to have_link(@henry.full_name)
    end
  end
end
