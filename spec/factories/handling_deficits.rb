FactoryBot.define do
  factory :handling_deficit do
    working_session
    location { 'global' }
    phase { nil }
    deficit { 'oversteer' }
  end
end
