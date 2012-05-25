Given /^I signed in as a user$/ do
  @user = FactoryGirl.create(:user)
  visit new_user_session_path
  step %{I fill in "Email" with "#{@user.email}"}
  step %{I fill in "Password" with "#{@user.password}"}
  step %{I press "Sign in"}
end

Given /^current user field "(.*?)" is "(.*?)"$/ do |field, value|
  @user[field.to_sym] = value
  @user.save!
end
