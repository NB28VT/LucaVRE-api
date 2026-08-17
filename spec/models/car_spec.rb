require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "#fetch_xml" do
    it "returns car_profile XML with chassis_name from cars.json" do
      car = Car.find("porsche_911_lmgt3_r_992")

      expect(car.fetch_xml).to eq(<<~XML)
        <car_profile>
          <chassis_name>Porsche 911 LMGT3 R (992)</chassis_name>
        </car_profile>
      XML
    end
  end
end
