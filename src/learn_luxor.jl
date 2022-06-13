## Imports
using Luxor
using Random
## Learning Luxor
#
#Going through some example calls/use with the Luxor Julia library.
#

## Test graphic -- red circle
Drawing(500, 500, "tests/01_japan.pdf")
origin() # setting zero point to center.
# the following two commands are 
setcolor("red")
circle(Point(0, 0), 100, :fill)
finish()
preview()


## Rectangles and other objects
Drawing(2048, 2048, "tests/02_rect_circles.pdf")
origin()

setcolor("blue")
rect(-1000,-1000, 500, 500, :fill)
setcolor("#111111")
line(Point(0,0), Point(-500, -500), :stroke)

finish()

## Fun with random points and connections

function get_random_points(num_points, min_x, max_x, min_y, max_y)
	point_array = []

	for i = 1:num_points
		x = rand()*(max_x-min_x)+min_x
		y = rand()*(max_y-min_y)+min_y
		push!(point_array, Point(x, y))
	end

	return point_array
end

function plot_point_array(point_array; max_dist=300, color="11")
	c = string("#",color,color,color)
	setcolor(c)
	for i = 1:length(point_array)-1
		if distance(point_array[i], point_array[i+1]) < max_dist
			line(point_array[i], point_array[i+1], :stroke)
		end
	end
end

Drawing(2048, 2048, "tests/03_mesh.pdf")
origin()
pa = get_random_points(400, -1000, 1000, -1000, 1000)
plot_point_array(pa)

finish()

## More weird random points
function perturb!(pa; noise_amp=3.0)
	for i = 1:length(pa)
		nx = pa[i].x + (noise_amp*(rand() - 0.5))
		ny = pa[i].y + (noise_amp*(rand() - 0.5))
		new_point = Point(nx, ny)
		pa[i] = new_point
	end
end


Drawing(2048, 2048, "tests/04_mesh2.pdf")
origin()
pa = get_random_points(400, -1000, 1000, -1000, 1000)
for i = 1:10
	# randomly perturbing the points
	for d = 11:33
		c = d*3
		plot_point_array(pa, color=c)
		shuffle!(pa)
		perturb!(pa, noise_amp=5.)
	end
end
finish()
preview()




