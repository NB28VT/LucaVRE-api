class DiagnosticService
    def initialize(working_session)
        @working_session = working_session
    end

    def call
        car_data = @working_session.car.fetch_xml
        track_data = @working_session.track.fetch_xml
        handling_deficits = @working_session.handling_deficits.map do |deficit|
          PromptSerializers::HandlingDeficitPromptSerializer.new(deficit).serialize
        end.join("\n  ")

        payload = DiagnosticPayloadBuilder.new(car_data: car_data, track_data: track_data, handling_deficits: handling_deficits).call

        response = AnthropicSdkService.new.generate_response(payload)
        return response
    end
end