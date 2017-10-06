class Dojo < ActiveRecord::Base
    validates :branch, :street, :city, :state, presence:true
    validates :branch, uniqueness:true
    has_many :students, :dependent => :destroy
end
