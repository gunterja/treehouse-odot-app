require "spec_helper"

describe "Logging In" do
  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Jeremy", last_name: "Gunter", email: "jeremy@example.com", password: "password1", password_confirmation: "password1")
    visit new_user_session_path
    fill_in "Email", with: "jeremy@example.com"
    fill_in "Password", with: "password1"
    click_button "Log In"

    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")

  end


  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email", with: "jeremy@example.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email", with: "jeremy@example.com")
  end

end