require 'rails_helper'
require_relative '../../../app/serializers/prompt_serializers/handling_deficit_prompt_serializer'

RSpec.describe PromptSerializers::HandlingDeficitPromptSerializer do
  describe '.generate_prompt_from_definitions' do
    subject(:prompt) { described_class.generate_prompt_from_definitions }

    it 'returns a string containing the base prompt' do
      expect(prompt).to be_a(String)
      expect(prompt).to include(described_class::BASE_PROMPT)
    end

    it 'documents each serialization mapping entry' do
      described_class::SERIALIZATION_MAPPING.each do |key, mapping|
        expect(prompt).to include("#{key}:")
        expect(prompt).to include("Code: #{mapping[:code]}")
        expect(prompt).to include("Definition: #{mapping[:definition]}")
        mapping[:value_map].each do |db_value, abbreviated|
          expect(prompt).to include("#{db_value}: #{abbreviated}")
        end
      end
    end
  end

  describe '#serialize' do
    subject(:serialized) { described_class.new(deficit).serialize }

    let(:deficit) do
      build(:handling_deficit, location: 'high_speed', phase: 'entry', symptom: 'understeer')
    end

    it 'returns loc, phase, and sym shorthand segments' do
      expect(serialized).to eq('loc:hi_spd;phase:entry;sym:us')
    end
  end
end
