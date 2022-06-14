## Main execution deck for generating the graphics
using Luxor
using Random
using JLD
using Plots
using LinearAlgebra

## Library files 
include("3DRender.jl") # a bunch of 3D functions 
include("net_visualizations.jl")
include("SSRL_dumpster_diving.jl")

## Some constants 
θ_x_max = 0.7 # num radians from the center to the extreme right/left edges 
θ_y_max = 0.7 # num radians from center to the extrem top/bottom edges

x̂_max   = 1024.0 # num absolute units from center to extreme right/left edges
ŷ_max   = 1024.0 # num absolute units from center to extreme top/bottom edges

meta = (θ_x_max, θ_y_max, x̂_max, ŷ_max)

quad_climb = 0.01
## Setting up net variables.
layer_sizes = [2, 5, 2]
# layer_sizes = [5, 10, 1]
perc_net_pts = get_perc_net_points(layer_sizes, -500, 500, -500, 500)

z = 75
s_0 = 20

real_net_pts = [ [perc_to_real(P, z, meta) for P in PP] for PP in perc_net_pts ]

# Getting data 
if !@isdefined(S)
	S = get_action_archive()
end
## Setting up the display
Drawing(x̂_max*2, ŷ_max*2, "tests/FINAL_1.pdf")
origin()

# Cool central network sketches

maxi = 1500
for i=reverse(1:50:maxi)

	add_vec = [0, (z/2)-(i^2)*0.001, i]

	newnet_ = translate_net_pos(real_net_pts, add_vec)
	newnet = push_nodes(newnet_, S, 1, Int(round(i/3)), learning_rate=0.02, random_move=0)

	
	α = 1-(i/float(maxi))
	α=α^2
	circle_size = s_0*(z/newnet[1][1][3])
	lw = 5*(z/newnet[1][1][3])
	# println("circle size: ", circle_size)
	draw_real_net(newnet, meta; circle_color=(1-α,1-α,1-α,1.), line_color=(0.4, 0.4, 0.4, α), line_weight=lw, circle_size=circle_size)
end
# Front-and-center network 
# draw_real_net(newnet, meta; circle_color=(0.,0.,0.,1.), line_color=(0., 0., 0., 1.), line_weight=7, circle_size=s_0*1.2)



# Cool left network 
layer_sizes2 = [5, 3, 2]
perc_net_pts2 = get_perc_net_points(layer_sizes2, -896, -896+350, 100, 100+350)
real_net_pts2 = [ [perc_to_real(P, z, meta) for P in PP] for PP in perc_net_pts2 ]

for i=reverse(1:50:maxi)

	add_vec = [-log(i)*3, -(i^2)*0.001, i]

	newnet_ = translate_net_pos(real_net_pts2, add_vec)
	newnet = push_nodes(newnet_, S, 1, Int(round(i/3)), learning_rate=0.02, random_move=0)

	
	α = 1-(i/float(maxi))
	α=α^2
	circle_size = s_0*(z/newnet[1][1][3])
	lw = 5*(z/newnet[1][1][3])
	# println("circle size: ", circle_size)
	draw_real_net(newnet, meta; circle_color=(1-α,1-α,1-α,1.), line_color=(0.4, 0.4, 0.4, α), line_weight=lw, circle_size=circle_size)
end
# Front-and-center network 
# draw_real_net(newnet, meta; circle_color=(0.,0.,0.,1.), line_color=(0., 0., 0., 1.), line_weight=7, circle_size=s_0*1.2)

# Cool right network 
layer_sizes2 = [2, 3, 5]
perc_net_pts2 = get_perc_net_points(layer_sizes2, 896-350, 896, 100, 100+350)
real_net_pts2 = [ [perc_to_real(P, z, meta) for P in PP] for PP in perc_net_pts2 ]

for i=reverse(1:50:maxi)

	add_vec = [log(i)*3, -(i^2)*0.001, i]

	newnet_ = translate_net_pos(real_net_pts2, add_vec)
	newnet = push_nodes(newnet_, S, 1, Int(round(i/3)), learning_rate=0.02, random_move=0)

	
	α = 1-(i/float(maxi))
	α=α^2
	circle_size = s_0*(z/newnet[1][1][3])
	lw = 5*(z/newnet[1][1][3])
	# println("circle size: ", circle_size)
	draw_real_net(newnet, meta; circle_color=(1-α,1-α,1-α,1.), line_color=(0.4, 0.4, 0.4, α), line_weight=lw, circle_size=circle_size)
end
# Front-and-center network 
# draw_real_net(newnet, meta; circle_color=(0.,0.,0.,1.), line_color=(0., 0., 0., 1.), line_weight=7, circle_size=s_0*1.2)


finish()
# preview()
## Analysis 







