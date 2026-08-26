class Car < ActiveFile::Base
  set_root_path Rails.root.join("config")
  set_filename "cars"

  field :name

  def fetch_xml
    <<~XML.chomp
      <car_profile>
        <chassis_name>#{name}</chassis_name>
      </car_profile>
    XML
  end

  class << self
    def extension
      "json"
    end

    def load_file
      JSON.parse(File.read(full_path))["cars"]
    end
  end
end
