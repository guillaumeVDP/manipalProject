# == Schema Information
#
# Table name: musics
#
#  id          :integer          not null, primary key
#  nom         :string(255)
#  compositeur :string(255)
#  path        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  altimg      :string(255)
#

require 'digest'
class Music < ActiveRecord::Base
	def create
		Music.create(music_params)
	end
	private
	def music_params
		params.require(:music).permit(:nom, :compositeur, :path, :altimg)
	end

	validates 	:compositeur, :presence => true,
				      :length => { :minimum => 3 }
	validates 	:nom, :presence => true,
				      :length => { :minimum => 3 },
				      :uniqueness => true
	validates 	:path, :presence => true
end
