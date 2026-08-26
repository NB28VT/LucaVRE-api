require 'rails_helper'

RSpec.describe DiagnosticService do
  describe '#call' do
    let(:working_session) do
      create(:working_session, car_id: 'porsche_911_lmgt3_r_992', track_id: 'spa_francorchamps_gp')
    end
    let(:anthropic_sdk_service) { instance_double(AnthropicSdkService) }
    let(:expected_car_block) do
      {
        type: 'text',
        text: <<~XML.chomp,
          <car_data>
            <car_profile>
              <chassis_name>Porsche 911 LMGT3 R (992)</chassis_name>
            </car_profile>
          </car_data>
        XML
        cache_control: { type: 'ephemeral' }
      }
    end
    let(:expected_track_block) do
      {
        type: 'text',
        text: <<~XML.chomp,
          <track_data>
            <track_profile>
              <track_name>Spa-Francorchamps - Grand Prix</track_name>
            </track_profile>
          </track_data>
        XML
        cache_control: { type: 'ephemeral' }
      }
    end
    let(:expected_handling_deficits_block) do
      {
        type: 'text',
        text: <<~XML.chomp,
          <handling_deficits>
            <handling_deficit>loc:glbl;sym:os</handling_deficit>
            <handling_deficit>loc:hi_spd;phase:entry;sym:us</handling_deficit>
          </handling_deficits>
        XML
        cache_control: { type: 'ephemeral' }
      }
    end
    let(:expected_payload) do
      {
        model: DiagnosticPayloadBuilder::DEFAULT_ANTHROPIC_MODEL,
        max_tokens: DiagnosticPayloadBuilder::DEFAULT_MAX_TOKENS,
        effort: DiagnosticPayloadBuilder::DEFAULT_EFFORT,
        system: DiagnosticPayloadBuilder::DEFAULT_SYSTEM_RULES,
        messages: [
          {
            role: 'user',
            content: [
              expected_car_block,
              expected_track_block,
              expected_handling_deficits_block
            ]
          }
        ]
      }
    end

    before do
      create(:handling_deficit, working_session: working_session, location: 'global', phase: nil, symptom: 'oversteer')
      create(:handling_deficit, working_session: working_session, location: 'high_speed', phase: 'entry', symptom: 'understeer')

      allow(AnthropicSdkService).to receive(:new).and_return(anthropic_sdk_service)
      allow(anthropic_sdk_service).to receive(:generate_response)
    end

    it 'passes AnthropicSdkService the expected payload as a positional argument' do
      described_class.new(working_session).call

      expect(anthropic_sdk_service).to have_received(:generate_response).with(expected_payload)
    end

    it 'uses default model, max_tokens, effort, and system rules' do
      described_class.new(working_session).call

      expect(anthropic_sdk_service).to have_received(:generate_response) do |payload|
        expect(payload[:model]).to eq(DiagnosticPayloadBuilder::DEFAULT_ANTHROPIC_MODEL)
        expect(payload[:max_tokens]).to eq(DiagnosticPayloadBuilder::DEFAULT_MAX_TOKENS)
        expect(payload[:effort]).to eq(DiagnosticPayloadBuilder::DEFAULT_EFFORT)
        expect(payload[:system]).to eq(DiagnosticPayloadBuilder::DEFAULT_SYSTEM_RULES)
      end
    end

    it 'wraps the session car XML in an ephemeral-cached text block' do
      described_class.new(working_session).call

      expect(anthropic_sdk_service).to have_received(:generate_response) do |payload|
        expect(payload[:messages].first[:content][0]).to eq(expected_car_block)
      end
    end

    it 'wraps the session track XML in an ephemeral-cached text block' do
      described_class.new(working_session).call

      expect(anthropic_sdk_service).to have_received(:generate_response) do |payload|
        expect(payload[:messages].first[:content][1]).to eq(expected_track_block)
      end
    end

    it 'wraps the serialized handling deficits in an ephemeral-cached text block' do
      described_class.new(working_session).call

      expect(anthropic_sdk_service).to have_received(:generate_response) do |payload|
        expect(payload[:messages].first[:content][2]).to eq(expected_handling_deficits_block)
      end
    end
  end
end
