## Functions for 3D Rendering 
"""
P = (x̂, ŷ) -- desired perceived coordinates on the screen. 
z 		   -- desired z position in real space 
meta	   -- tuple of metadata about screen, FOV. 
"""
function perc_to_real(P, z, meta)
	@assert length(meta) == 4 
	@assert length(P) == 2

	θ_x_max, θ_y_max, x̂_max, ŷ_max = meta # default metadata packaging 
	x̂, ŷ = P # desired apparent x,y position on the screen 

	# Solving for x,y necessary to produce x̂, ŷ, z 
	θ_x = (x̂/x̂_max)*θ_x_max
	θ_y = (ŷ/ŷ_max)*θ_y_max 

	x = z*tan(θ_x)
	y = z*tan(θ_y)

	# OPTIONALLY: Do secondary vanishinng point perspective... 
	return [x,y,z]
end

"""
From x/y angle and z position to absolute position.

Currently uses single-point vanishing point perspective. In the future, 
it should probably use more. 
"""
function ang2_to_perc(θ_x, θ_y, z, meta)
	@assert length(meta) == 4 

	θ_x_max, θ_y_max, x̂_max, ŷ_max = meta # default metadata packaging 

	x = (θ_x/θ_x_max)*x̂_max
	y = (θ_y/θ_y_max)*ŷ_max

	return [x,y]
end

"""
Convert from real coordinates `R` (3-tuple) and `meta` to the perceived 
coordinates on the screen. 
"""
function real_to_perc(R, meta) 
	@assert length(meta) == 4 
	@assert length(R) == 3

	x,y,z = R 

	θ_x = atan(x/z)
	θ_y = atan(y/z)

	return ang2_to_perc(θ_x, θ_y, z, meta)
end

"""
Returns the relative size of R_2/R_1
"""
function rel_size(R_1, R_2)
	@assert length(meta) == 4 
	@assert length(R_1) == length(R_2) == 3 

	return R_1[3]/R_2[3]
	# OPTIONALLY: Use actual perspective lol 
end






"""
Lattice function. Produces a lattice of points at some desired absolute `z`
with a predefined x_range, y_range.

Ranges are diameters, not radii. 
"""
function get_lattice(num_x, num_y, x̂_range, ŷ_range, z, meta)
	lattice_real = [] # list of actual 3-coordiantes
	lattice_perc = []

	xspace = x̂_range/(num_x-1) 
	yspace = ŷ_range/(num_y-1)

	x_ofst = -x̂_range/2 
	y_ofst = -ŷ_range/2


	for i = 1:num_y 
		for j = 1:num_x 
			perc_p = [x_ofst + (i-1)*xspace, y_ofst + (j-1)*yspace]
			push!(lattice_perc, perc_p)
			push!(lattice_real, perc_to_real(perc_p, z, meta))
		end
	end

	return lattice_real, lattice_perc
end


"""
Takes `lattice` (list of 3-arrays represeting real 3d points). 
"""
function draw_lattice_circles(lattice, meta, color, size)
	setcolor(color)
	for l in lattice
		circle(Point(real_to_perc(l, meta)...), size, :fill)
	end 
end

"""
"""