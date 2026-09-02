module Dictionaries
    module CarDictionary
      CAR_KEY_MAPPING = {
        "Engine Placement" => "ep",
        "Aero Platform"    => "ap",
        "Wheelbase"        => "wb",
        "Primary Quirk"    => "pq"
      }.freeze
  
      ENGINE_PLACEMENT_MAPPING = {
        "Front Engine Rear Wheel Drive" => "fr",
        "Mid Engine Rear Wheel Drive" => "mr",
        "Rear Engine Rear Wheel Drive" => "rr"
      }.freeze
  
      AERO_PLATFORM_MAPPING = {
        "Pitch Sensitive" => "ps",
        "Aero Stable" => "as"
      }.freeze
  
      WHEELBASE_MAPPING = {
        "Short" => "sh",
        "Long" => "lg"
      }.freeze
  
      PRIMARY_QUIRK_MAPPING = {
        "Lift-Off Oversteer" => "loo",
        "Entry Understeer" => "eus",
        "Power-On Understeer" => "pus",
        "Snap Oversteer" => "nos",
        "Curb Instability" => "cus" 
      }.freeze
    end
  end
end  