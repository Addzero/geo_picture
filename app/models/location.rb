class Location < ActiveRecord::Base
	validates :latitude, :longitude, 
		:presence => true,
		:numericality => true
	#remainder omitted
	attr_accessor :latitude, :longitude
	R = 3_959 # Earth's radius in miles, approx

	def near?(lat, long, mile_radius)
		# omitted
	end

	private
		def to_radians(degrees)
			#degrees * Math::PI / 180
		end
		def haversine_distance(loc)
			
		end
end