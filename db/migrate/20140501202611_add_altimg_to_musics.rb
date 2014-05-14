class AddAltimgToMusics < ActiveRecord::Migration
  def change
    add_column :musics, :altimg, :string
  end
end
