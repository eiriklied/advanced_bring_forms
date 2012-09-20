class Complaint < ActiveRecord::Base
  attr_accessible :comment, :first_name, :last_name, :phone
end
