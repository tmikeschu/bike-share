require_relative '../spec_helper'

describe 'Trip' do
  before do
    station1 = Station.create !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    station2 = Station.create !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    subscription = SubscriptionType.create !!!!!!!!!!!!!!!!!
  end

  describe 'validates' do
    it 'presence of duration' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_date' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_station_id' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_date' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_station_id' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of bike_id' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of subscription_type_id' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of user_zip_code' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of created_at' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of updated_at' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_date' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_time' do
      invalid_trip = subscription.Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  created_at: "2016-12-05 22:53:08",
                                  updated_at: "2016-12-05 22:53:08",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end
  end

end
