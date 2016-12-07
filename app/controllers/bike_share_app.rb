require_relative '../models/station'

class BikeShareApp < Sinatra::Base

  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  # get '/' do
  #   erb :"dashboard"
  # end

  ### Start Stations Routes ###
  get '/station-dashboard' do
    erb :"stations/dashboard"
  end

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

  get '/stations/new' do
    @cities = City.all
    erb :"stations/new"
  end

  post '/stations' do
    # require 'pry'; binding.pry
    date = format_date(params[:station][:installation_date])
    params[:station][:installation_date] = date
    station = Station.create(params[:station])
    redirect "/stations"
  end

  def format_date(date)
    date = date.split("/").reverse
    date[1], date[2] = date[2], date[1]
    date = date.join("/")
    date
  end

  get '/stations/:id' do
    @station = Station.find(params[:id])
    erb :"stations/show"
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])
    @cities  = City.all
    erb :"stations/edit"
  end

  put '/stations/:id' do
    Station.update(params[:id], params[:station])
    redirect "/stations/#{params[:id]}"
  end

  delete '/stations/:id' do
    Station.destroy(params[:id])
    redirect '/stations'
  end

  ### Start Trips Routes ###
  get '/trip-dashboard' do
    @monthly_rides = {2013=>{8.0=>1916, 9.0=>23377, 10.0=>27822, 11.0=>23309, 12.0=>19185}, 2014=>{1.0=>23789, 2.0=>18487, 3.0=>24586, 4.0=>26199, 5.0=>28461, 6.0=>29945, 7.0=>31227, 8.0=>31163, 9.0=>31653, 10.0=>34195, 11.0=>25485, 12.0=>19656}, 2015=>{1.0=>27829, 2.0=>26386, 3.0=>31588, 4.0=>31344, 5.0=>29515, 6.0=>31886, 7.0=>32457, 8.0=>31880}}
    erb :"trips/dashboard"
  end

  get '/trips' do
    @page = params[:page].to_i
    @trips = Trip.order(:start_date).offset(@page * 30).limit(30)
    erb :"trips/index"
  end

  get '/trips/new' do
    @trips = Trip.all
    erb :"trips/new"
  end

  post '/trips' do
    trip = Trip.create(params[:trip])
    redirect "/trips/#{trip.id}"
  end

  get '/trips/:id' do
    @trip = Trip.find(params[:id])
    erb :"trips/show"
  end

  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    @trips  = Trip.all
    erb :"trips/edit"
  end

  put '/trips/:id' do
    Trip.update(params[:id], params[:trip])
    redirect "/trips/#{params[:id]}"
  end

  delete '/trips/:id' do
    Trip.destroy(params[:id])
    redirect '/trips'
  end

  ### Start Weather Conditions Routes ###
  get '/weather-dashboard' do
    @metrics = WeatherCondition.master_metrics
    erb :"conditions/dashboard"
  end

  get '/conditions' do
    @page = params[:page].to_i
    @conditions = WeatherCondition.order(:date).offset(@page * 30).limit(30)
    erb :"conditions/index"
  end

  get '/conditions/new' do
    erb :"conditions/new"
  end

  post '/conditions' do
    params[:zip_code] = 94107
    condition = WeatherCondition.create(params[:conditions])
    redirect "/conditions"
  end

  get '/conditions/:id' do
    @condition = WeatherCondition.find(params[:id])
    erb :"conditions/show"
  end

  get '/conditions/:id/edit' do
    @condition = WeatherCondition.find(params[:id])
    @conditions  = WeatherCondition.all
    erb :"conditions/edit"
  end

  put '/conditions/:id' do
    WeatherCondition.update(params[:id], params[:condition])
    redirect "/conditions/#{params[:id]}"
  end

  delete '/conditions/:id' do
    WeatherCondition.destroy(params[:id])
    redirect '/conditions'
  end


end
