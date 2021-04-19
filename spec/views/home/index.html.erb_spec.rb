require 'rails_helper'

RSpec.describe 'home/index', type: :view do

  it 'renders the content successfully' do
    render
    assert_select 'h1', text: 'Welcome to Takshashila Library'.to_s, count: 1
    assert_select 'strong', text: '– George R.R. Martin'.to_s
  end
end
