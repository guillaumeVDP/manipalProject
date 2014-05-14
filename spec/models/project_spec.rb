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

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
