require "rails_helper"

RSpec.describe CurrentWheatherUpdater do
  describe ".call" do
    subject { described_class.call }
    let!(:indication) { Indication.create(temperature: 13.2, unit: "C", epochTime: 1665146580) }

    it "it return current temperature in Moscow" do
      VCR.use_cassette("accuwheathercurrenttemp") do
        expect(subject.epochTime/10000).to eq 166515
      end
    end
  end
end
