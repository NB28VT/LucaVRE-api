FactoryBot.define do
  factory :handling_deficit do
    working_session
    location { 'global' }
    deficit { 'oversteer' }
  end
end
