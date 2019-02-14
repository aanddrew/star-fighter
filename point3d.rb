class Point3d
	attr_accessor :x, :y, :z
	#constructor
	def initialize(x,y,z)
		@x = x
		@y = y
		@z = z
	end


	def getProjection(camera)
		dx = @x - camera.loc.x
		dy = @y - camera.loc.y
		dz = @z - camera.loc.z

		if dz <= 0
			if dz >= -10
				returned = [-1,-1]
				if dx > 0
					returned[0] = camera.width + 1
				end
				if dy > 0
					returned[1] = camera.height + 1
				end
				return returned
			end
			return [-1,-1]
		end
		
		px = dx/(dz)
		py = dy/(dz)
		return [camera.width/2+ px, camera.height/2 +py]
	end

	#getters
	def x
		@x
	end
	def y
		@y
	end
	def z
		@z
	end
	#setters
	def x=(x)
		@x = x
	end
	def y=(y)
		@y = y
	end
	def z=(z)
		@z = z
	end
end

puts "Point3d loaded"