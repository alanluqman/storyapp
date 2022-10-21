require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    user = User.new(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from UK.', post_counter: 0)
    Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'title is not blank' do
    expect(subject.title).to eq('Hello')
  end

  it 'comment_counter is an integer' do
    user = User.new(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    Comment.new(post: subject, author: user, text: 'Hi Alan!')
    expect(subject.comments_counter).to be_an(Integer)
  end

  it 'blank title raises error' do
    subject.title = ''
    expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed)
  end

  it 'title is too short' do
    subject.title = 'Hi'
    expect(subject).to_not be_valid
  end

  it 'title is too long' do
    subject.title = 'a' * 255
    expect(subject).to_not be_valid
  end

  it 'comment_counter thats not an integer raises error' do
    subject.comments_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'likes_counter thats not an integer raises an error' do
    subject.likes_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'update_posts_counter updates the post_counter of the author' do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from Mexico.', post_counter: 0)
    Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
    user.increment!(:post_counter)
    expect(user.post_counter).to eq(1)
  end
end
