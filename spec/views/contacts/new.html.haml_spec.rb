require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :sex => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :company => "MyString",
      :email => "MyString",
      :is_broker => false,
      :is_charterer => false,
      :is_owner => false,
      :region => "MyString",
      :size => 1,
      :comment => "MyText"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_sex[name=?]", "contact[sex]"

      assert_select "input#contact_first_name[name=?]", "contact[first_name]"

      assert_select "input#contact_last_name[name=?]", "contact[last_name]"

      assert_select "input#contact_company[name=?]", "contact[company]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_is_broker[name=?]", "contact[is_broker]"

      assert_select "input#contact_is_charterer[name=?]", "contact[is_charterer]"

      assert_select "input#contact_is_owner[name=?]", "contact[is_owner]"

      assert_select "input#contact_region[name=?]", "contact[region]"

      assert_select "input#contact_size[name=?]", "contact[size]"

      assert_select "textarea#contact_comment[name=?]", "contact[comment]"
    end
  end
end
