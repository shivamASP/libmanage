require 'rails_helper'

RSpec.describe 'Issuebooks', type: :request do
  describe 'GET /viewissuedbooks' do
    it 'returns http success' do
      get '/issuebook/viewissuedbooks'
      expect(response).to have_http_status(:success)
    end
  end
end
