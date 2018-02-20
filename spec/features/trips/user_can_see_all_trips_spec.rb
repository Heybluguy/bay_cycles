require 'rails_helper'

describe "As a visitor" do
  before :each do
    @station = create(:station)
    @trips = create_list(:trip, 60)
  end
  describe "when I visit trips index" do
    it "I see first 30 trips" do
      visit trips_path

      expect(page).to have_content(@trips[0].id)
      expect(page).to have_content(@trips[0].duration)
      expect(page).to have_content(@trips[0].start_date)
      expect(page).to have_content(@trips[0].start_station.name)
      expect(page).to have_content(@trips[0].end_date)
      expect(page).to have_content(@trips[0].end_station.name)
      expect(page).to have_content(@trips[0].bike_id)
      expect(page).to have_content(@trips[0].subscription_type)
      expect(page).to have_content(@trips[0].zip_code)
      expect(page).to have_content(@trips[30].duration)
      expect(page).to_not have_content(@trips[31].id)
    end
  end
end
