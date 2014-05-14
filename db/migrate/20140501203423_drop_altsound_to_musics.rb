class DropAltsoundToMusics < ActiveRecord::Migration
  def change
  	remove_column(:musics, :altsound)
  end
end
