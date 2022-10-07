require "rails_helper"

RSpec.describe WheatherUpdater do
  describe ".call" do
    subject { described_class.call }
    let!(:indication) { Indication.create(temperature: 13.2, unit: "C", epochTime: 1665146580) }

    it "creates new indications in database" do
      VCR.use_cassette("accuwheatheralltemp") do
        expect { subject }.to change(Indication, :count).from(1).to(25)
      end
    end
  end
end
