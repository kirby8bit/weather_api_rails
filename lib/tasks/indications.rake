namespace :indications do
  desc "Update indications from AccuWeather"
  task update: :environment do
    WheatherUpdater.call
  end
end
