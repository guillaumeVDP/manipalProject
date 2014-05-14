# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  length         :string(255)
#  content        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  picture        :string(255)
#  picture_detail :string(255)
#

require 'digest'
class Project < ActiveRecord::Base
	def create
		Project.create(project_params)
	end
	private
	def project_params
		params.require(:project).permit(:title, :length, :picture, :picture_detail, :content)
	end

	picture_regex = /\A[\w+\-.]+\.(jpg|png|jpeg)\z/i

	validates 	:title, :presence => true,
				      :length => { :minimum=> 3 },
				      :uniqueness => { :case_sensitive => false }
	validates 	:content, :presence => true,
				      :length => { :maximum => 255 }
	validates 	:picture, :presence => true,
				      :format => { :with => picture_regex }
end
