require 'rails_helper'

RSpec.describe Track, type: :model do
  describe "#fetch_xml" do
    it "returns track_profile XML with track_name from tracks.json" do
      track = Track.find("spa_francorchamps_gp")

      expect(track.fetch_xml).to eq(
        <<~XML.chomp
          <track_profile>
            <track_name>Spa-Francorchamps - Grand Prix</track_name>
          </track_profile>
        XML
      )
    end
  end
end
