require 'ruby2d'
# require "Curses"
# include Curses
require_relative 'point3d'
require_relative 'camera'

def setCrosshairPoints(crosshairPoints)
	mousex = get :mouse_x
	mousey = get :mouse_y
	size = 15
	crosshairPoints[0].x = mousex - Window.width/2 + size
	crosshairPoints[0].y = mousey - Window.height/2 + size
	crosshairPoints[4].x = mousex - Window.width/2 + size
	crosshairPoints[4].y = mousey - Window.height/2 + size

	crosshairPoints[1].x = mousex - Window.width/2 + size
	crosshairPoints[1].y = mousey - Window.height/2 - size
	crosshairPoints[5].x = mousex - Window.width/2 + size
	crosshairPoints[5].y = mousey - Window.height/2 - size

	crosshairPoints[2].x = mousex - Window.width/2 - size
	crosshairPoints[2].y = mousey - Window.height/2 - size
	crosshairPoints[6].x = mousex - Window.width/2 - size
	crosshairPoints[6].y = mousey - Window.height/2 - size

	crosshairPoints[3].x = mousex - Window.width/2 - size
	crosshairPoints[3].y = mousey - Window.height/2 + size
	crosshairPoints[7].x = mousex - Window.width/2 - size
	crosshairPoints[7].y = mousey - Window.height/2 + size
end

def main
	set title: "3d test"
	set width: 1024
	set height: 768

	moving_up = false
	moving_down = false
	moving_left = false
	moving_right = false

	cam = Camera.new(Window.width, Window.height)
	personalCam = Camera.new(Window.width, Window.height)
	cam.loc.z = -100
	points = []

	crosshairPoints = [Point3d.new(0,0,1),
					   Point3d.new(0,0,1),
					   Point3d.new(0,0,1),
					   Point3d.new(0,0,1),
					   Point3d.new(0,0,1.5),
					   Point3d.new(0,0,1.5),
					   Point3d.new(0,0,1.5),
					   Point3d.new(0,0,1.5)]

	#push a square tunnel to the points array
	for i in 1..500 do
		#top left
		points.push(Point3d.new(0,0,i*10))
		#bottom left
		points.push(Point3d.new(0,10000,i*10))
		#bottom right
		points.push(Point3d.new(10000,10000,i*10))
		#top right
		points.push(Point3d.new(10000,0,i*10))
	end
		
	cam.loc.x = 5000
	cam.loc.y = 5000

	update do
		Window.clear
		#logic here
		cam.loc.z += 1

		setCrosshairPoints(crosshairPoints)

		#inputs
		on :key_down do |event|
			case event.key
			when "w"
				moving_up = true
			when "a"
				moving_left = true
			when "s"
				moving_down = true
			when "d"
				moving_right = true
			end
		end
		on :key_up do |event|
			case event.key
			when "w"
				moving_up = false
			when "a"
				moving_left = false
			when "s"
				moving_down = false
			when "d"
				moving_right = false
			end
			# puts event.key
		end

		# puts moving_left

		if (moving_right)
			cam.loc.x += 200
		end
		if (moving_left)
			cam.loc.x -= 200
		end
		if (moving_up)
			cam.loc.y -= 200
		end
		if (moving_down)
			cam.loc.y += 200
		end

		#rendering from here down
		crosshairPoints.each do |pnt|
			coords = pnt.getProjection(personalCam)
			Square.new(
				x: coords[0],
				y: coords[1],
				size: 5,
				color: 'green')
		end

		# render tunnel points
		# points.each do|pnt|
		# 	coords = pnt.getProjection(cam)
		# 	dz = pnt.z- cam.loc.z
		# 	if (dz > 0 and dz < 100)
		# 		Square.new(
		# 			x: coords[0],
		# 			y: coords[1],
		# 			size: 1000/dz,
		# 			color: 'white',
		# 			z: 1)
		# 	end
		# end
		# rendering gray rectangles
		for i in 0..points.size do
			coords1 = []
			coords2 = []
			coords3 = []
			coords4 = []
			if i < points.size-4
				dz = points[i].z - cam.loc.z
				if dz < 100 and dz > 0
					if (i % 4 != 3)
						coords1 = points[i].getProjection(cam)
						coords2 = points[i+1].getProjection(cam)
						coords3 = points[i+5].getProjection(cam)
						coords4 = points[i+4].getProjection(cam)
					else
						coords1 = points[i].getProjection(cam)
						coords2 = points[i-3].getProjection(cam)
						coords3 = points[i+1].getProjection(cam)
						coords4 = points[i+4].getProjection(cam)
					end
					Quad.new(
					  x1: coords1[0], y1: coords1[1],
					  x2: coords2[0], y2: coords2[1],
					  x3: coords3[0], y3: coords3[1],
					  x4: coords4[0], y4: coords4[1],
					  color: 'gray',
					  z: 10
					)
				end
			end
		end
	end

	show
end

inMenu = true

main()