module PromptSerializers
  class HandlingDeficitPromptSerializer

      # TODO: REFINE WITH GEMINI
      BASE_PROMPT = "You will be given a series of <handling_deficit> objects under the <handling_deficits> tag. The deficits are noted in an abbreviated format for prompt compression. Each code refers to some feedback about the deficit in an abbreviated format. 
      
      For example, the following ,
      loc:hi_spd;phase:entry;sym:us

      Means 'In high speed corners, at the entry to the corners, I have a symptom of understeer'

      I will provide the mapping of codes, their possible values and to their meaning below
      "
      # TODO: Define all speeds in km/h in the system rules
      SERIALIZATION_MAPPING = {
          location: {
              code: "loc",
              definition: "The location on track where the deficit is occurring. glbl refers to the entire track. The remaining values are for types of corners based on apex speed in km/h:
              hi_spd: corners with an apex speed over 175
              med_spd: corners with an apex speed between 105 and 175
              lo_spd: corners with an apex speed under 105 km/h",
              attribute: "location",
              value_map: {
                  "global" => "glbl",
                  "high_speed" => "hi_spd",
                  "mid_speed" => "med_spd",
                  "low_speed" => "lo_spd"
              }
          },
          phase: {
              code: "phase",
              definition: "The phase of the corner where the deficit is occuring.",
              attribute: "phase",
              value_map: {
                  "entry" => "entry",
                  "mid_corner" => "mid",
                  "exit" => "exit"
              }
          },
          symptom: {
              code: "sym",
              definition: "The symptom of the deficit. understeer: Front tires exceed their slip angle limit before the rears, causing the car to wash wide of the intended line. oversteer: Rear tires exceed their slip angle limit before the fronts, causing the rear end to slide out or spin.",
              attribute: "symptom",
              value_map: {
                  "understeer" => "us",
                  "oversteer" => "os"
              }
          }
      }.freeze

    def self.generate_prompt_from_definitions
      prompt = <<~HANDLING_DEFCIT_DEFINITIONS
        #{BASE_PROMPT}
        #{SERIALIZATION_MAPPING.map do |key, value|
          "#{key}: 
          - Code: #{value[:code]}
          - Definition: #{value[:definition]}
          - Value Map:
          -#{value[:value_map].map do |key, value|
              "#{key}: #{value}"
          end.join("\n")}"
        end.join("\n")}
      HANDLING_DEFCIT_DEFINITIONS
    end

    def initialize(deficit)
      @deficit = deficit
    end

    # Serializers defcits into shorthand codes for the purposes of prompt compression
    # e.g. loc:med_spd;phase:mid;sym:os
    def serialize
      SERIALIZATION_MAPPING.filter_map do |_key, value|
        attribute = value[:attribute]
        raw = @deficit[attribute]
        next if attribute == "phase" && !raw.present?

        "#{value[:code]}:#{value[:value_map][raw]}"
      end.join(";")
    end
  end
end