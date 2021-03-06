require 'rails_helper'

describe Condition, type: :model do
  it { should validate_presence_of(:date)}
  it { should validate_presence_of(:max_temperature)}
  it { should validate_presence_of(:mean_temperature)}
  it { should validate_presence_of(:min_temperature)}
  it { should validate_presence_of(:mean_humidity)}
  it { should validate_presence_of(:mean_visibility)}
  it { should validate_presence_of(:mean_wind_speed)}
  it { should validate_presence_of(:precipitation)}
end

describe "class methods" do
  before :all do
    @station_1 = create(:station)
    @station_2 = create(:station)
    @condition_1 = create(:condition, date: "2018-03-19", max_temperature: 50, precipitation: 0, mean_wind_speed: 0, mean_visibility: 0)
    @condition_2 = create(:condition, date: "2018-04-19", max_temperature: 55, precipitation: 0.2, mean_wind_speed: 2, mean_visibility: 2)
    @condition_3 = create(:condition, date: "2018-05-19", max_temperature: 61, precipitation: 0.3, mean_wind_speed: 4, mean_visibility: 4)
    @condition_4 = create(:condition, date: "2018-06-19", max_temperature: 66, precipitation: 0.5, mean_wind_speed: 5, mean_visibility: 5)
    @condition_5 = create(:condition, date: "2018-07-19", max_temperature: 75, precipitation: 0.7, mean_wind_speed: 7.99, mean_visibility: 7.99)
    @station_3 = create(:station)
    @trip_1 = create(:trip, condition: @condition_1)
    @trip_2 = create(:trip, condition: @condition_2)
    @trip_3 = create(:trip, condition: @condition_2)
    @trip_4 = create(:trip, condition: @condition_3)
    @trip_5 = create(:trip, condition: @condition_3)
    @trip_6 = create(:trip, condition: @condition_4)
    @trip_7 = create(:trip, condition: @condition_4)
    @trip_8 = create(:trip, condition: @condition_4)
    @trip_9 = create(:trip, condition: @condition_5)
    @trip_10 = create(:trip, condition: @condition_5)
    @trip_11 = create(:trip, condition: @condition_5)
    @trip_12 = create(:trip, condition: @condition_5)
  end

  describe ".temp_ranges" do
    describe ".average_rides_for_temps" do
      it "returns the breakout of average number of rides on days with a high temperature in 10 degree chunks" do
        range_1 = [50, 59.99]
        range_2 = [60, 69.99]

        expect(Condition.average_rides_for_temps(range_1)).to eq(1.5)
        expect(Condition.average_rides_for_temps(range_2)).to eq(2.5)
      end
    end

    describe  ".most_rides_for_temps" do
      it "returns the breakout of highest number of rides on days with a high temperature in 10 degree chunks" do
        range_1 = [50, 59.99]
        range_2 = [60, 69.99]

        expect(Condition.most_rides_for_temps(range_1)).to eq(2)
        expect(Condition.most_rides_for_temps(range_2)).to eq(3)
      end
    end

    describe ".lowest_rides_for_temps" do
      it "returns the breakout of lowest number of rides on days with a high temperature in 10 degree chunks" do
        range_1 = [50, 59.99]
        range_2 = [60, 69.99]

        expect(Condition.lowest_rides_for_temps(range_1)).to eq(1)
        expect(Condition.lowest_rides_for_temps(range_2)).to eq(2)
      end
    end
  end

  describe ".precipitation_ranges" do
    describe ".average_rides_for_precipitation" do
      it "returns the breakout of average number of rides on days with precipitation in half-inch increments" do
        range_1 = [0, 0.49]
        range_2 = [0.5, 0.99]

        expect(Condition.average_rides_for_precipitation(range_1)).to eq(1.7)
        expect(Condition.average_rides_for_precipitation(range_2)).to eq(3.5)
      end
    end

    describe  ".most_rides_for_precipitation" do
      it "returns the breakout of highest number of rides on days with precipitation in half-inch increments" do
        range_1 = [0, 0.49]
        range_2 = [0.5, 0.99]

        expect(Condition.most_rides_for_precipitation(range_1)).to eq(2)
        expect(Condition.most_rides_for_precipitation(range_2)).to eq(4)
      end
    end

    describe ".lowest_rides_for_precipitation" do
      it "returns the breakout of lowest number of rides on days with precipitation in half-inch increments" do
        range_1 = [0, 0.49]
        range_2 = [0.5, 0.99]

        expect(Condition.lowest_rides_for_precipitation(range_1)).to eq(1)
        expect(Condition.lowest_rides_for_precipitation(range_2)).to eq(3)
      end
    end
  end

  describe ".wind_speed_ranges" do
    describe ".average_rides_for_wind" do
      it "returns the breakout of average number of rides on days with mean wind speeds in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.average_rides_for_wind(range_1)).to eq(1.5)
        expect(Condition.average_rides_for_wind(range_2)).to eq(3)
      end
    end

    describe  ".most_rides_for_wind" do
      it "returns the breakout of highest number of rides on days with mean wind speeds in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.most_rides_for_wind(range_1)).to eq(2)
        expect(Condition.most_rides_for_wind(range_2)).to eq(4)
      end
    end

    describe ".lowest_rides_for_wind" do
      it "returns the breakout of lowest number of rides on days with mean wind speeds in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.lowest_rides_for_wind(range_1)).to eq(1)
        expect(Condition.lowest_rides_for_wind(range_2)).to eq(2)
      end
    end
  end

  describe ".visibility_ranges" do
    describe ".average_rides_for_visibility_" do
      it "returns the breakout of average number of rides on days with mean visibility in miles in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.average_rides_for_visibility(range_1)).to eq(1.5)
        expect(Condition.average_rides_for_visibility(range_2)).to eq(3)
      end
    end

    describe  ".most_rides_for_visibility_" do
      it "returns the breakout of highest number of rides on days with mean visibility in miles in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.most_rides_for_visibility(range_1)).to eq(2)
        expect(Condition.most_rides_for_visibility(range_2)).to eq(4)
      end
    end

    describe ".lowest_rides_for_visibility_" do
      it "returns the breakout of lowest number of rides on days with mean visibility in miles in four mile increments" do
        range_1 = [0, 3.99]
        range_2 = [4, 7.99]

        expect(Condition.lowest_rides_for_visibility(range_1)).to eq(1)
        expect(Condition.lowest_rides_for_visibility(range_2)).to eq(2)
      end
    end

    describe ".weather_on_most_popular_day" do
      it "returns weather on the most popular ride date" do

        expect(Condition.weather_on_most_popular_day).to eq(@condition_5)
      end
    end

    describe ".weather_on_least_popular_day" do
      it "returns weather on the least popular ride date" do

        expect(Condition.weather_on_least_popular_day).to eq(@condition_1)
      end
    end
  end
end
