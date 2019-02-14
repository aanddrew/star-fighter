require 'ruby2d'
require_relative 'point3d'

class Enemy
	def size
		return [4000,2000]
	end

	def initialize(x, y, z)
		@loc = Point3d.new(x,y,z)
		@corner_loc = Point3d.new(x-size[0]/2, y-size[1]/2, z)
		@speed = rand(6)/4 + 0.1
	end

	def getRenderedSize(cam)
		dz = @loc.z - cam.loc.z
		cornerCoords = @corner_loc.getProjection(cam)
		middleCoords = @loc.getProjection(cam)
		half_width = middleCoords[0]-cornerCoords[0]
		half_height = middleCoords[1]-cornerCoords[1]
		# puts half_width
		if (half_width < cam.width)
			return [half_width*2, half_height*2]
		else
			return [cam.width, cam.height]
		end
	end

	def update
		@loc.z -= @speed
		@corner_loc.z -= @speed
		# @loc.x += rand(500) - 25
		# @loc.y += rand(550) -25
	end

	#getters
	def speed
		@speed
	end
	def loc
		@loc
	end
	def corner_loc
		@corner_loc
	end
end