class WheatherUpdater
  BASE_URL = 'http://dataservice.accuweather.com'.freeze
  APP_ID = ENV.fetch('WHEATHER_APP_ID').freeze
  CITY = ENV.fetch('CITY').freeze

  def self.call
    new.call
  end

  def call
    #получим сначала по Москве ключ:
    key = HTTParty
      .get("#{BASE_URL}/locations/v1/cities/search", query: {apikey: APP_ID, q: CITY})[0]["Key"]

    #получим по ключу города текущую температуру:

    temperature_hour =
      {
        tempreture: HTTParty
          .get("#{BASE_URL}/currentconditions/v1/#{key}", query: {apikey: APP_ID}).first["Temperature"]["Metric"]["Value"],
        date:  HTTParty
          .get("#{BASE_URL}/currentconditions/v1/#{key}", query: {apikey: APP_ID}).first["LocalObservationDateTime"]
      }


    temperature_24_hours = HTTParty
      .get("#{BASE_URL}/currentconditions/v1/#{key}/historical/24", query: {apikey: APP_ID}).map do | temperature |
        {
          temperature: temperature["Temperature"]["Metric"]["Value"],
          date: temperature["LocalObservationDateTime"]
        }
      end

    binding.pry
  end

end
