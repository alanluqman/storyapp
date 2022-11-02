require 'rails_helper'

RSpec.describe 'users index', type: :feature do
    before(:example) do
      @subject1 = User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.', post_counter: 0) 
      @subject2 = User.create(name: 'Nich', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Negiria.', post_counter: 0) 
    end
    it 'I can see the username of all other users.' do
        visit '/'
      expect(page).to have_content(@subject1.name)
      expect(page).to have_content(@subject2.name)
    end

    it 'I can see the profile picture for each user.' do
      visit user_path(id: @subject1.id)
      find("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'I can see the number of posts each user has written.' do
    visit '/'
    expect(page).to have_content(@subject1.post_counter)
    expect(page).to have_content(@subject2.post_counter)
  end

   it "When I click on a user, I am redirected to that user's show page." do
    visit '/'
    click_link(@subject1.name)
    expect(page).to have_content(@subject1.name)
  end

    
end