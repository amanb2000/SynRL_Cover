using Luxor
using Random
using JLD
using Plots
using LinearAlgebra

## Drawing a "normal" neural net 
function get_even_net_points(layer_sizes::Vector, min_x, max_x, min_y, max_y)
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
		points = [Point(x,y*space_between_neurons) for y in 0:num-1]
		points .-= Point(0, num*0.5*space_between_neurons-((max_y+min_y)*0.5))
		push!(node_poss, points)
		cnt+=1
	end
	return node_poss
end
function draw_net(layer_sizes::Vector, min_x, max_x, min_y, max_y; alpha=1.0)
	node_poss = get_even_net_points(layer_sizes, min_x, max_x, min_y, max_y)

	# lines
	setcolor((0.3, 0.3, 0.3, alpha))
	dolines(node_poss)


	# circles
	setcolor((0.1, 0.1, 0.1, alpha))
	docircles(node_poss)

	return node_poss
end

function dolines(node_poss)
	for l = 1:length(node_poss)-1
		for p1 in node_poss[l]
			for p2 in node_poss[l+1]
				line(p1,p2, :stroke)
			end
		end
	end
end

function docircles(node_poss)
	for layer in node_poss
		for p in layer 
			# println(p)
			circle(p, 20, :fill)
		end
	end
end



## Setting up the drawing
Drawing(2048, 2048, "tests/06_networks.pdf")
origin() # setting zero point to center.
# the following two commands are 
rad = 300
abs_offset = -300
for ofst = 0:10:100
	node_poss = draw_net([5,10,3], -rad+ofst+abs_offset, rad+(ofst*5)+abs_offset, -rad+ofst+abs_offset, rad+(ofst*5)+abs_offset; alpha= (ofst/100.)^2)
end



finish()	









