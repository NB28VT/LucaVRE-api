require 'rails_helper'

RSpec.describe HandlingDeficit, type: :model do
  describe 'validations' do
    it 'is valid with a location and deficit' do
      handling_deficit = build(:handling_deficit)

      expect(handling_deficit).to be_valid
    end

    it 'is invalid without a location' do
      handling_deficit = build(:handling_deficit, location: nil)

      expect(handling_deficit).not_to be_valid
      expect(handling_deficit.errors[:location]).to include("can't be blank")
    end

    it 'is invalid without a deficit' do
      handling_deficit = build(:handling_deficit, deficit: nil)

      expect(handling_deficit).not_to be_valid
      expect(handling_deficit.errors[:deficit]).to include("can't be blank")
    end

    it 'is invalid with a location not in the allowed list' do
      handling_deficit = build(:handling_deficit, location: 'front')

      expect(handling_deficit).not_to be_valid
      expect(handling_deficit.errors[:location]).to include('is not included in the list')
    end

    %w[global high_speed mid_speed low_speed].each do |valid_location|
      it "is valid with a location of #{valid_location}" do
        handling_deficit = build(:handling_deficit, location: valid_location)

        expect(handling_deficit).to be_valid
      end
    end

    it 'is invalid with a deficit other than oversteer, understeer or balanced' do
      handling_deficit = build(:handling_deficit, deficit: 'wobbly')

      expect(handling_deficit).not_to be_valid
      expect(handling_deficit.errors[:deficit]).to include('is not included in the list')
    end

    %w[oversteer understeer balanced].each do |valid_deficit|
      it "is valid with a deficit of #{valid_deficit}" do
        handling_deficit = build(:handling_deficit, deficit: valid_deficit)

        expect(handling_deficit).to be_valid
      end
    end
  end
end
