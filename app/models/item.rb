class Item < ActiveRecord::Base
	serialize :tags, Array
	validates_uniqueness_of :url
end
