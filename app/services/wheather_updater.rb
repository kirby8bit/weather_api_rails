class WheatherUpdater
  BASE_URL = 'http://dataservice.accuweather.com'.freeze
  APP_ID = ENV.fetch('WHEATHER_APP_ID').freeze
  CITY = ENV.fetch('CITY').freeze

  def self.call
    new.call
  end

  def call

    get_key

    temperature_24_hours = tf_hours_list.map do | temperature |
        {
          temperature: temperature["Temperature"]["Metric"]["Value"],
          unit: temperature["Temperature"]["Metric"]["Unit"],
          epochTime: temperature["EpochTime"]
        }
    end

    ActiveRecord::Base.transaction do
      temperature_24_hours.each do | temperature |
        Indication
          .find_or_initialize_by(epochTime: temperature[:epochTime])
          .update(
            temperature: temperature[:temperature],
            unit: temperature[:unit]
          )
      end
    end

    Indication.last(24)
  end

  private

  def get_key
    @key ||= HTTParty
    .get("#{BASE_URL}/locations/v1/cities/search", query: {apikey: APP_ID, q: CITY})[0]["Key"]
  end

  def tf_hours_list
    @tf_hours_list ||= send_request(@key)
  end

  def send_request(key)
    HTTParty
    .get("#{BASE_URL}/currentconditions/v1/#{key}/historical/24", query: {apikey: APP_ID})
  end
end
