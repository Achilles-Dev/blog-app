require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get '/users' }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'returns text in response body' do
      expect(response.body).to include('Here is a list all users')
    end
  end

  describe 'GET #show' do
    before(:example) { get '/users/1' }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end

    it 'returns text in response body' do
      expect(response.body).to include('Here are the details of the selected user')
    end
  end
end
