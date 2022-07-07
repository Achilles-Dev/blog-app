require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Solo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'FullStack developer from Ghana.') }

  before { subject.save }

  it 'name must not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter must be an integer' do
    subject.post_counter = '2s'
    expect(subject).to_not be_valid
  end

  it 'post_counter must greater than or equal to zero' do
    subject.post_counter = -4
    expect(subject).to_not be_valid
  end
end
