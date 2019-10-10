# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'User accept friend request' do
  scenario 'log in and Send friend request' do
    @user = FactoryBot.create(:user)
    @other = FactoryBot.create(:user)
    login_as(@users, :scope => :user)
    visit friendship_request_path
    first(:link, 'Add Friend').click
    logout(:user)
    login_as(@other, scope: :user)
    visit friendships_path
    expect(page).to have_content("#{@user.name} #{@user.email}")
    first(:link, 'Confirm Friendship').click
    expect(page).to have_content("Now you are a #{@user.name}'s friend")
  end
end