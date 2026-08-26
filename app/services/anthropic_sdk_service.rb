class AnthropicSdkService
    def initialize
        @anthropic = Anthropic::Client.new(
            api_key: Rails.application.credentials.dig(:anthropic, :api_key)
        )
    end

    def generate_response(payload)
        response = @anthropic.messages.create(payload)

        return response.content
    end
end
