Given(/^I am a guest$/) do
end

When(/^I fill a register form with a valid data$/) do
  visit('/register')
  fill_in "user_email", with: "user@microsoft.com"
  fill_in "user_first_name", with: "Victor"
  fill_in 'user_last_name', with: 'Tarasenko'
  fill_in 'user_role', with: 'admin'
  fill_in 'user_dept', with: 'it'
  click_button 'Register'
end
