class Link < ActiveRecord::Base

	validates :title, presence: true, length: {minimum: 2}
	validates :link_url, presence: true, length: {minimum: 5}
	validates :synopsis, presence: true, length: {minimum: 5}
	validates :year, presence: true, numericality: {only_integer: true}
	validates :username, presence: true, length: {minimum: 2}
	
end