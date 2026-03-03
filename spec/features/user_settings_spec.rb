require 'rails_helper'

RSpec.feature "UserSettings", type: :feature do
  describe "user settings" do
    let(:user) { create(:user) }

    before :each do
      @user = create(:user)
      sign_in(@user)
      sleep 1
    end

    # before :each do
    #   sign_in user
    # end

    it "should allow users to edit their personal information" do
      visit "/member/#{@user.id}"
      # visit member_path(user)
      expect(page).to have_text(@user.name)
      expect(page).to have_text(@user.address)
      expect(page).to have_text(@user.profile_title)
      expect(page).to have_text("About")
      expect(page).to have_text(@user.about)
      find(:xpath, '//a[contains(@class, "edit-profile")]//i[contains(@class, "fa-solid fa-pencil")]').click
      # find("a.edit-profile").click
      # x path is powerful query language used to locate elementson web page allows to specify path to desired element based on its postion attributes and relationship with other elements in document
      # x path expresion written as string n can be used in capybara to find elements for interactions verification during web testing
      # # finding page elements using x path
      sleep 1
      expect(page).to have_text("Edit your personal details")
      fill_in "user_first_name", with: "Arpita"
      fill_in "user_last_name", with: "Singh"
      fill_in "user_city", with: "Neuquen"
      fill_in "user_state", with: "Neuquen"
      fill_in "user_country", with: "Argentina"
      fill_in "user_pincode", with: "8300"
      fill_in "user_profile_title", with: "Ruby on Rails Semi Senior Developer"
      sleep 2
      click_button "Save Changes"
      expect(page).to have_current_path("/member/#{@user.id}")
      expect(page).to have_text("Arpita Singh")
      expect(page).to have_text("Ruby on Rails Semi Senior Developer")
      expect(page).to have_text("Neuquen, Neuquen, Argentina, 8300")
      sleep 5
    end
  end
end