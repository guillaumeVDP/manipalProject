class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :nom
      t.string :compositeur
      t.string :path

      t.timestamps
    end
  end
end
