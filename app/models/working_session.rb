class WorkingSession < ApplicationRecord
    validates :track_id, presence: true
    validates :car_id, presence: true
end
