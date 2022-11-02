require 'rails_helper'

RSpec.describe 'renders post index Page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            bio: 'Teacher from UK.', post_counter: 0)
    @post = Post.create(author: @subject1, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    visit "/users/#{@subject1.id}/posts"
  end

  it 'I can see the user profile picture.' do
    find("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see the user username.' do
    expect(page).to have_content(@subject1.name)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content(@subject1.post_counter)
  end

  it 'I can see a post title.' do
    expect(page).to have_content(@post.title)
  end

  it 'I can see some of the post body.' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content('Hello')
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content(@post.comments_counter)
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content(@post.likes_counter)
  end

  it 'When I click on a post, it redirects me to that post show page.' do
    @subject1.posts.each do |post|
      click_on post.text
      expect(current_path).to eq "/users/#{@subject1.id}/posts/#{@post.id}"
    end
  end
end
