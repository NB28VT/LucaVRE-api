class HandlingDeficit < ApplicationRecord
  belongs_to :working_session

  validates :location, presence: true, inclusion: { in: %w[global high_speed mid_speed low_speed] }
  validates :deficit, presence: true, inclusion: { in: %w[oversteer understeer balanced] }
end
