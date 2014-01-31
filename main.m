load('spikeTime_inputs.mat');
input_fire_times = peakLocs;
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;

inputNeuron;
%20 connections -one from each input to each hidden
%20 connections - one from each output to the output

%need to keep for each neuron:
%1. a list of times they have fired
%2. a list of the weights coming towards them

input_hidden_weights = randn(20,1);
hidden_fire_times = zeros(20,20);
hidden_output_weights = randn(20,1);
output_fire_times = [];
threshold = 1;
%run the network
pointer = 0;
for i = 1:0.0001:20
    %check if input neuron has fired
    if i >= input_fire_times(pointer)
        pointer = pointer + 1;
    end
    
    %check if the hidden neurons have fired
    for j = 1:20
        potential = hiddenPotential(j, i, input_hidden_weights);
        
        %if passes the threshold, add a firing time to that neuron
        if potential >= threshold
            hidden_fire_times(nnz(hidden_fire_times)+1) = i;
            
        end
        
    end
    
    %check if the output neuron has fired
    potential = outputPotential(i, hidden_output_weights, hidden_fire_times);
    if potential >= threshold
        output_fire_times = [output_fire_times; i];
        
        
    end
    
    
    
end

