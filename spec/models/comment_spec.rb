require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    user = User.new(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.', post_counter: 0)
    post = Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
    Comment.new(post: post, author: user, text: 'Hi Alan!')
  end

  it '# is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it '# comment_counter gets incremented by 1' do
    expect(subject.post.comments_counter) == 1
  end
end
