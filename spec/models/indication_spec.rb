require 'rails_helper'

RSpec.describe Indication, type: :model do
  describe 'validations check' do
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:epochTime) }
  end
end
