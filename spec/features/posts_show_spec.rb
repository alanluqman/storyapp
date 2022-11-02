require 'rails_helper'

RSpec.describe 'renders post index Page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            bio: 'Teacher from UK.', post_counter: 0)
    @subject2 = User.create(name: 'Alex', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from USA.',
                            post_counter: 0)
    @post = Post.create(author: @subject1, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    Comment.create(text: 'this is my first comment', user_id: @subject2.id, post_id: @post.id)
    visit "/users/#{@subject1.id}/posts/#{@post.id}"
  end

  it 'I can see the post title.' do
    expect(page).to have_content(@post.title)
  end

  it 'I can see who wrote the post.' do
    expect(page).to have_content(@post.author.name)
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content(@post.comments_counter)
  end

  it 'I can see how many likes it has.' do
    expect(page).to have_content(@post.likes_counter)
  end

  it 'I can see the post body.' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the username of each commentor.' do
    expect(page).to have_content(@subject2.name)
  end

  it 'I can see the comment each commentor left.' do
    expect(page).to have_content('this is my first comment')
  end
end
