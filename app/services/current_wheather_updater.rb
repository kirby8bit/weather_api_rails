class CurrentWheatherUpdater
  BASE_URL = 'http://dataservice.accuweather.com'.freeze
  APP_ID = ENV.fetch('WHEATHER_APP_ID').freeze
  CITY = ENV.fetch('CITY').freeze

  def self.call
    new.call
  end

  def call

    get_key

    temperature_hour =
      {
        temperature: one_hour_list["Temperature"]["Metric"]["Value"],
        unit: one_hour_list["Temperature"]["Metric"]["Unit"],
        epochTime: one_hour_list["EpochTime"]
      }

    Indication
      .find_or_initialize_by(epochTime: temperature_hour[:epochTime])
      .update(
        temperature: temperature_hour[:temperature],
        unit: temperature_hour[:unit]
      )

    Indication.find_by(epochTime: temperature_hour[:epochTime])
  end

  private

  def get_key
    @key ||= HTTParty
    .get("#{BASE_URL}/locations/v1/cities/search", query: {apikey: APP_ID, q: CITY})[0]["Key"]
  end

  def one_hour_list
    @one_hour_list ||= send_request(@key)
  end

  def send_request(key)
    HTTParty
    .get("#{BASE_URL}/currentconditions/v1/#{key}", query: {apikey: APP_ID}).first
  end
end
