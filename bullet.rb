class Bullet
	#start is a point being the start of the bullet.
	#speed is the speed of the bullet 
	def initialize(start, speed)
		@start = start
		@speed = speed
		# @end = Point3d.new(@start.x, @start.y, @start.z + 10)
		# if speed < 0
		# 	@end = Point3d.new(start.x, start.y, start.z - 10)
		# end
	end

	def update()
		@start.z += @speed
		# @end.z += @speed
	end

	#getters
	def start
		@start
	end
	# def end
	# 	@end
	# end
end