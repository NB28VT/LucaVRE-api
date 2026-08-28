require 'builder'

module PromptSerializers
  class HandlingDeficitXmlSerializer < BaseXmlSerializer
    HANDLING_DEFICIT_LOCATION_MAPPING = {
        "high_speed" => "hi_spd",
        "mid_speed" => "med_spd",
        "low_speed" => "lo_spd",
        "global" => "glbl"
    }.freeze

    HANDLING_DEFICIT_PHASE_MAPPING = {
        "entry" => "entry",
        "mid_corner" => "mid",
        "exit" => "exit"
    }.freeze

    HANDLING_DEFICIT_SYMPTOM_MAPPING = {
        "understeer" => "us",
        "oversteer" => "os"
    }.freeze

    def initialize(handling_deficit)
      @handling_deficit = handling_deficit
    end

    def to_xml
      xml = ::Builder::XmlMarkup.new(indent: XML_INDENTATION)
      xml.handling_deficit(serialize_deficit_characteristics)
    end

    private

    def serialize_deficit_characteristics
      [
        "loc:#{HANDLING_DEFICIT_LOCATION_MAPPING[@handling_deficit.location]}",
        ("phase:#{HANDLING_DEFICIT_PHASE_MAPPING[@handling_deficit.phase]}" if @handling_deficit.phase.present?),
        "sym:#{HANDLING_DEFICIT_SYMPTOM_MAPPING[@handling_deficit.symptom]}"
      ].compact.join(';')
    end
  end
end
