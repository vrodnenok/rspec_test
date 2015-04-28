require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
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
      ),
      Contact.create!(
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
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 6
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
