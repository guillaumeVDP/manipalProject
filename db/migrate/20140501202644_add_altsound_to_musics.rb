class AddAltsoundToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :altsound, :string
  end
end
