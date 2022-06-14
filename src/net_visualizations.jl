using Luxor
using Random
using JLD
using Plots
using LinearAlgebra

## Drawing a "normal" neural net 
function get_perc_net_points(layer_sizes::Vector, min_x, max_x, min_y, max_y)
	# Figuring out some parameters
	lr_space = max_x-min_x
	space_between_layers = lr_space/(length(layer_sizes)-1)

	ud_space = max_y-min_y
	space_between_neurons = ud_space/max(layer_sizes...)

	# Generating the point position for each node
	node_poss = []
	cnt=1
	for num in layer_sizes
		x = min_x + space_between_layers*(cnt-1)
		points_ = [ [x,y*space_between_neurons] for y in 0:num-1]

		points = [p-[0, (num-1)*0.5*space_between_neurons-((max_y+min_y)*0.5)] for p in points_]
		 
		push!(node_poss, points)
		cnt+=1
	end
	return node_poss
end

function draw_real_circles(lattice, meta, color, size)
	setcolor(color)
	for l in lattice
		circle(Point(real_to_perc(l, meta)...), size, :fill)
	end 
end

"""
takes in a real coordinate-defined set of network points (organized in layers)
called `node pts` and draws em in 3D space. 
"""
function draw_real_lines(node_pts, meta, color, weight)
	setcolor(color)
	setline(weight)
	for i = 1:length(node_pts)-1
		for pre in node_pts[i]
			for post in node_pts[i+1]
				p1 = Point(real_to_perc(pre, meta)...)
				p2 = Point(real_to_perc(post, meta)...)

				line(p1,p2, :stroke)
			end	
		end


	end
end

function translate_point_list(pt_list, add_vec)
	@assert length(add_vec) == 3
	return [p+add_vec for p in pt_list]
end

function translate_net_pos(node_pts, add_vec)
	@assert length(add_vec) == 3

	new_pts = []
	for layer in node_pts 
		push!(new_pts, translate_point_list(layer, add_vec))
	end
	return new_pts
end

"""
Takes a set of real points organized into layers of points and draws a 
FCNN in 3D space. It's just 1 net, though! 
"""
function draw_real_net(real_node_pts, meta; circle_color="black", 
		line_color="grey", line_weight=1, circle_size=20)

	draw_real_lines(real_node_pts, meta, line_color, line_weight)
	
	draw_real_circles(flatten(real_node_pts), meta, circle_color, circle_size)
	
end


function flatten(net_points)
	retval = []
	for row in net_points
		push!(retval, row...)
	end
	return retval
end






