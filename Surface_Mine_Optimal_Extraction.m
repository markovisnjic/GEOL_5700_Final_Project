%%2D Surface Mine Optimal Extraction
%Final project 
%Marko Visnjic for GEOL 5700

% Describes a single surface miner progressing through a surface mine with
% a randomly generated and distributed lithology. The miner will start at
% the highest value block and search to go further down in a path that will
% optimize the value obtained by the miner.

% Rules:
% The miner can only move down left and right
% At first the miner will look at only which block is greater in it's
% immediate vacinity. When the miner mines a block it's value will be set 
% to zero.

%%Initialize Parameters

grade_init = 0.9;

%%Algorithm
Layer_Search(grade_init);

%Start the Miner



%%Plot
% figure(1)
% clf
% image(Lith,'CDataMapping','Scaled')
% colorbar
