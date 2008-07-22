class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :name
      t.string :code
      t.integer :paste_count

      t.timestamps
    end

    %w[
     active4d
     all_hallows_eve
     amy
     blackboard
     brilliance_black
     brilliance_dull
     cobalt
     dawn
     eiffel
     espresso_libre
     idle
     iplastic
     lazy
     mac_classic
     magicwb_amiga
     pastels_on_dark
     slush_poppies
     spacecadet
     sunburst
     twilight
     zenburnesque
    ].each do |code|
      Theme.create!(:name => code, :code => code)
    end

  end

  def self.down
    drop_table :themes
  end
end
