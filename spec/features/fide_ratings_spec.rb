require 'rails_helper'

describe FideRating do
  describe "list", js: true do
    before(:each) do
      @r1 = FactoryBot.create(:fide_rating, list: "2011-09-01", fide_player: FactoryBot.create(:fide_player))
      @r2 = FactoryBot.create(:fide_rating, list: "2011-09-01", fide_player: FactoryBot.create(:fide_player, gender: "F"))
      @r3 = FactoryBot.create(:fide_rating, list: "2011-09-01", fide_player: FactoryBot.create(:fide_player))
      @r4 = FactoryBot.create(:fide_rating, list: "2011-07-01", fide_player: FactoryBot.create(:fide_player))
      @r5 = FactoryBot.create(:fide_rating, list: "2011-07-01", fide_player: @r1.fide_player)
      @xp = "#fide_rating_results table tr"
    end

    it "unfiltered" do
      visit fide_ratings_path
      expect(page).to have_selector(@xp, count: 6)
    end

    it "list" do
      visit fide_ratings_path
      page.select "2011 Sep", from: "List"
      click_button "Search"
      expect(page).to have_selector(@xp, count: 4)
    end

    it "gender" do
      visit fide_ratings_path
      page.select "Male", from: "Gender"
      click_button "Search"
      expect(page).to have_selector(@xp, count: 5)
      page.select "Female", from: "Gender"
      click_button "Search"
      expect(page).to have_selector(@xp, count: 2)
    end

    it "FIDE ID" do
      visit fide_ratings_path
      page.fill_in "FIDE ID", with: @r1.fide_player.id
      click_button "Search"
      expect(page).to have_selector(@xp, count: 3)
      page.select "2011 Sep", from: "List"
      click_button "Search"
      expect(page).to have_selector(@xp, count: 2)
    end
  end
end
