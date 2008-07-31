class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :name
      t.string :code
      t.integer :paste_count

      t.timestamps
    end

    { 'active4d' => 'Active 4D',
      'all_hallows_eve' => 'All Hallows Eve',
      'amy' => 'Amy',
      'blackboard' => 'Blackboard',
      'brilliance_black' => 'Brilliance Black',
      'brilliance_dull' => 'Brilliance Dull',
      'cobalt' => 'Cobalt',
      'dawn' => 'Dawn',
      'eiffel' => 'Eiffel',
      'espresso_libre' => 'Espresso Libre',
      'idle' => 'IDLE',
      'iplastic' => 'iPlastic',
      'lazy' => 'LAZY',
      'mac_classic' => 'Mac Classic',
      'magicwb_amiga' => 'MagicWB (Amiga)',
      'pastels_on_dark' => 'Pastels on Dark',
      'slush_poppies' => 'Slush Poppies',
      'spacecadet' => 'SpaceCadet',
      'sunburst' => 'Sunburst',
      'twilight' => 'Twilight',
      'zenburnesque' => 'Zenburnesque',
    }.each_pair do |code, name|
      Theme.create!(:name => name, :code => code)
    end

  end

  def self.down
    drop_table :themes
  end
end
