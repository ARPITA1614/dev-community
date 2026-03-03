require 'rails_helper'

RSpec.feature "WorkExperiences", type: :feature do
  describe "work experiences" do
    describe "current user" do
      let(:user) { create(:user) }

      before :each do
        @user=create(:user)
        sign_in (@user)
        # sign_in user
      end

      it "should open the work experience form and display the validation errors if empty form is submitted" do
        # visit member_path(user)
        visit "/member/#{@user.id}"
        expect(page).to have_text(@user.name)
        expect(page).to have_text("Work Experiences")
        find('a[data-controller="bs-modal-form"] i.fas.fa-plus').click
        # find("a.add-work-experience").click
        sleep 2
        expect(page).to have_text("Add new work experience")
        click_button "Save Changes"
        sleep 2
        expect(page).to have_text("9 errors prohibited your work experience from being save.")
        expect(page).to have_text("Company can't be blank")
        expect(page).to have_text("Start date can't be blank")
        expect(page).to have_text("Job title can't be blank")
        expect(page).to have_text("Location can't be blank")
        expect(page).to have_text("Employment type can't be blank")
        expect(page).to have_text("Employment type not a valid employment type")
        expect(page).to have_text("Location type can't be blank")
        expect(page).to have_text("Location type not a valid location type")
        expect(page).to have_text("End date must be present if you are not currently working in this company")
        sleep 2
      end

      it "should open the work experience form and and save to db if all validation passed" do
        # visit member_path(user)
        visit "/member/#{@user.id}"
        expect(page).to have_text(@user.name)
        find("a.add-work-experience").click
        sleep 2
        expect(page).to have_text("Add new work experience")
        fill_in "work_experience_job_title", with: "Senior Ruby on Rails Developer"
        fill_in "work_experience_company", with: "Developer Community PVT. LTD."
        select "Full-time", from: "work_experience_employment_type"
        fill_in "work_experience_location", with: "Indore, India"
        select "Remote", from: "work_experience_location_type"
        fill_in "work_experience_start_date", with: "01/01/2018"
        fill_in "work_experience_end_date", with: "01/12/2020"
        fill_in "work_experience_description", with: "I worked here for two years as a full stack ruby on rails developer"
        sleep 2
        click_button "Save Changes"
        sleep 2
        # visit member_path(user)
        visit "/member/#{@user.id}"
        expect(page).to have_text("Senior Ruby on Rails Developer")
        expect(page).to have_text("Developer Community PVT. LTD. (Full-time)")
        expect(page).to have_text("Indore, India (Remote)")
        expect(page).to have_text("Jan 2018 - Dec 2020 (2 years 11 months)")
        sleep 2
      end
     end
   end
end