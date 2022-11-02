require 'rails_helper'

RSpec.describe 'renders users Show Page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.', post_counter: 0) 

    @post = Post.create(author: @subject1, title: 'demo', text: 'rails testing project')

    Post.create(author: @subject1, title: 'nick', text: 'nick start new role as web developer')
    Post.create(author: @subject1, title: 'rex', text: 'rex start new role as web developer')
    Post.create(author: @subject1, title: 'ogaga', text: 'ogaga start new role as web developer')

    visit user_path(id: @subject1.id)
end

  it 'I can see the profile picture for each user.' do
      find("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see the user username.' do
    expect(page).to have_content(@subject1.name)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content(@subject1.post_counter)
  end

  it 'I can see the user bio.' do
    expect(page).to have_content(@subject1.bio)
  end

  it 'I can see the user first 3 posts.' do
    expect(page).to have_content('Recent posts')
  end

  it 'I can see a button that lets me view all of a user posts.' do
    expect(page).to have_link('See all Posts') if @subject1.post_counter > 0
  end

  it 'When I click a user post, it redirects me to that post show page.' do
    @subject1.posts.each do |post|
      click_on post.text
      expect(current_path).to eq user_post_path(user_id: post.user.id, id: post.id)
    end
  end

  it 'When I click to see all posts, it redirects me to the user posts index page.' do
    if @subject1.post_counter > 0 
      click_on 'See all Posts'
      expect(current_path).to eq "users/#{@subject1.id}/posts"
    else 
      expect(page).to have_content('The list is empty for the posts by the user')
    end
  end
end