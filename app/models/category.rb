class Category < ActiveRecord::Base
	has_many :transactions
  belongs_to :category_type
  belongs_to :user

  validates_presence_of :name, :category_type_id, :user_id
end
