## Main execution deck for generating the graphics
using Luxor
using Random
using JLD
using Plots
using LinearAlgebra

## Library files 
include("3DRender.jl") # a bunch of 3D functions 
include("net_visualizations.jl")

## Some constants 
θ_x_max = 0.7 # num radians from the center to the extreme right/left edges 
θ_y_max = 0.7 # num radians from center to the extrem top/bottom edges

x̂_max   = 1024.0 # num absolute units from center to extreme right/left edges
ŷ_max   = 1024.0 # num absolute units from center to extreme top/bottom edges

meta = (θ_x_max, θ_y_max, x̂_max, ŷ_max)

## Setting up net variables.
layer_sizes = [2, 5, 1]
perc_net_pts = get_perc_net_points(layer_sizes, -500, 500, -500, 500)

z = 350
s_0 = 20

real_net_pts = [ [perc_to_real(P, z, meta) for P in PP] for PP in perc_net_pts ]

## Setting up the display
Drawing(x̂_max*2, ŷ_max*2, "tests/10_perspective_sizes.pdf")
origin()

# Traslating lattice forward and back
# for i = 0:2:25
# 	l = [R-[0.,0,i] for R in base_lattice]
# 	α = ((i/25.)^3)*0.9 + 0.1
# 	size= s_0*z/l[1][3]
# 	println("SIZE: ", size)
# 	draw_lattice_circles(l, meta, (0., 0., 0., α),size)
# end

xrand=3
yrand=10

for i=reverse(0:50:500)

	add_vec = [0, 0, i*3]

	newnet = translate_net_pos(real_net_pts, add_vec)

	
	
	α = 1-(i/500.)
	α=α^2
	circle_size = s_0*(z/newnet[1][1][3])
	# println("circle size: ", circle_size)
	draw_real_net(newnet, meta; circle_color=(1-α,1-α,1-α,1.), line_color=(0.3, 0.3, 0.3, α), line_weight=1, circle_size=circle_size)
end
# draw_lattice_circles(flatten(real_net_pts), meta, (0., 0., 0., α), s_0)


finish()
# preview()
## Analysis 







