require "rails_helper"

feature "Application" do
  given!(:user) { create :user_example_com }

  scenario "should display main menu" do
    sign_in_as 'user@example.com', 'password'
    visit root_path

    expect(page).to have_selector 'a', text: "Transactions"
    expect(page).to have_selector 'a', text: "Categories"
    expect(page).to have_selector 'a', text: "Accounts"
    expect(page).to have_selector 'a', text: "Cash Flows"
    expect(page).to have_selector 'a', text: "Statistics"
    expect(page).to have_selector 'a', text: "Sign out"
  end

  scenario 'can see active accounts summary' do
    create :account, name: 'Cash', user: user
    create :account, :deleted, name: 'Old Bank Card', user: user

    sign_in_as 'user@example.com', 'password'
    visit root_path

    within '#accounts_summary' do
      expect(page).to have_content 'Cash:'
      expect(page).not_to have_content 'Old Bank Card:'
    end
  end
end
