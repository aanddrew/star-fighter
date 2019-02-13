require_relative 'point3d'

class Camera
	def initialize(width, height)
		@loc = Point3d.new(0,0,0)
		@width = width
		@height = height
	end

	def move(dx, dy, dz)
		loc.x += dx
		loc.y += dy
		loc.z += dz
	end

	#getters
	def loc
		@loc
	end
	def width
		@width
	end
	def height
		@height
	end
end