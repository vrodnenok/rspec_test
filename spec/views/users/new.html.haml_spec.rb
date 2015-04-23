require 'spec_helper'

describe "devise/registrations/new.html.haml" do
  before :each do
    user = mock_model('User').as_new_record().as_null_object()
    assign(:user, user)
    render
  end
  it 'has new_user form' do
    expect(rendered).to have_selector('form#new_user')
  end  
  it 'has user_first_name field' do
    expect(rendered).to have_selector('#user_first_name')
  end
  it 'has user_last_name field' do
    expect(rendered).to have_selector('#user_last_name')
  end
  it 'has user_role field' do
    expect(rendered).to have_selector('#user_role')
  end
  it 'has user_dept field' do
    expect(rendered).to have_selector('#user_dept')
  end
  it 'has user_email field' do
    expect(rendered).to have_selector('#user_email')
  end
  it 'has user_password field' do
    expect(rendered).to have_selector('#user_password')
  end
  it 'has user_password_confirmation field' do
    expect(rendered).to have_selector('#user_password_confirmation')
  end
  it 'has register button' do
    expect(rendered).to have_selector('input[type="submit"]')
  end
end

