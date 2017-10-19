require 'rails_helper'

RSpec.feature  'Following Friends' do
  before do
    @john = create(:user)

    @sarah = create(:sarah)
    login_as(@john)
  end

  scenario 'if signed in' do
    visit '/'

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)

    href = "friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link('Follow', href: href)

    link = "a[href='/friendships?friend_id=#{@sarah.id}']"
    find(link).click

    href = "friendships?friend_id=#{@sarah.id}"
    expect(page).not_to have_link('Follow', href: href)
  end
end

