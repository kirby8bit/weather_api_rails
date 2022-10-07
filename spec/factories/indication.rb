FactoryBot.define do
  factory :indication, class: Indication do
    temperature { rand(-30..40) }
    unit { "C" }
    epochTime { "1665146580" }
  end
end
