class AddDetailsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :picture_detail, :string
  end
end
