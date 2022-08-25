# == Schema Information
#
# Table name: chores
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chore < ApplicationRecord
end
