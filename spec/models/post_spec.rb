require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Solo', text: 'This is my first post') }

  before { subject.save }

  it 'title must not be blank' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    subject.title = 'Solo' * 70
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be an integer' do
    subject.comments_counter = 'three'
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be an integer' do
    subject.likes_counter = 'four'
    expect(subject).to_not be_valid
  end

  it 'comments_counter must greater than or equal to zero' do
    subject.comments_counter = -4
    expect(subject).to_not be_valid
  end

  it 'likes_counter must greater than or equal to zero' do
    subject.likes_counter = -2
    expect(subject).to_not be_valid
  end
end
