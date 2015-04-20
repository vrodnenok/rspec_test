require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :sex => "Sex",
      :first_name => "First Name",
      :last_name => "Last Name",
      :company => "Company",
      :email => "Email",
      :is_broker => false,
      :is_charterer => false,
      :is_owner => false,
      :region => "Region",
      :size => 1,
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sex/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
  end
end
