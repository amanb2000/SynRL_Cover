## Scientific Imports
include("../../SpikeSynRL/Libraries/SSRL.jl")

## Getting the dataset
function get_action_archive()
	archive = load("../SpikeSynRL/Experiments/Results/Linear/SSRL_2022-06-10T22-01-00.819/outcome.jld")

	## Looking at the synapse states more closely
	# fieldnames(typeof(net.S[1][1,1].previous_actions))
	net = archive["net"]
	# return net.S[1][1,1].previous_actions # USE THIS TO ANIMATE THE RANDOM WALK!
	return net.S
end










