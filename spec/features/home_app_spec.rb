require 'rails_helper'

RSpec.feature "HomeApps", type: :feature do
   describe "Landing page" do
    it "shows the login page" do
      visit root_path

      expect(page).to have_text("Dev Community")
      expect(page).to have_text("Log in")
      expect(page).to have_link("Sign In")
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_link("Didn't receive confirmation instructions?")

      expect(page).to_not have_text("Search professionals across the world")
    end
  end
end
