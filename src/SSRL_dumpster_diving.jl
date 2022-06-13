using Luxor
using Random
using JLD
using Plots
using LinearAlgebra

## Scientific Imports
include("../../SpikeSynRL/Libraries/SSRL.jl")

## Getting the dataset
archive = load("../SpikeSynRL/Experiments/Results/Linear/SSRL_2022-06-10T22-01-00.819/outcome.jld")
archive

## What
for k in keys(archive)
	println("\t",k)
end

## Items of interest: 
# - weight record 
# - RL.<wherever the state record is...>
RL = archive["RL"]
weight_record = archive["weight_record"]
net = archive["net"]

## Looking at the synapse states more closely
fieldnames(typeof(net.S[1][1,1].previous_actions))

net.S[1][1,1].previous_actions # USE THIS TO ANIMATE THE RANDOM WALK!

## Some neural net drawings, though!












