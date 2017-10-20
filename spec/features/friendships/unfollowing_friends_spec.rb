require 'rails_helper'

RSpec.feature 'Unfollowing Friend' do
  before do
    @john = create(:user)
    @sarah = create(:sarah)
    login_as @john

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario do
    visit '/'
    click_link 'My Lounge'
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content("#{@sarah.full_name} unfollowed")
  end
end
