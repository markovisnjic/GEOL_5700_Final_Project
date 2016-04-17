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

cut_off_grade = 0.3;

% X Boundary
xmax = 10;

%Y Boundary
ymax = 10;

%%Algorithm
Lith = rand(xmax,ymax);
Lith(Lith<(cut_off_grade)) = 0;

summation = (1:xmax-1);
for i=1:xmax-1
    summation(i) = sum(Lith(1:3,i));
end
[max_value,Index_Miner_X]= max(summation);

% [T3_Max,Index_Miner_X]=Layer_Search_Type_2(cut_off_grade);
Index_Miner_Y = 1;
imax = xmax.*ymax;

Lith(Index_Miner_Y,Index_Miner_X)
%Start the Miner
Miner = Lith(Index_Miner_Y,Index_Miner_X);
for i=1:imax
    Lith(Index_Miner_Y,Index_Miner_X) = Miner;
    Miner = 0;
    if Index_Miner_X || Index_Miner_Y > 1
    value_left = Lith(Index_Miner_Y,Index_Miner_X-1);
    value_right = Lith(Index_Miner_Y,Index_Miner_X+1);
    value_below = Lith(Index_Miner_Y+1,Index_Miner_X);
    if (value_below < value_left) && (value_right < value_left)
       horiz_move = -1;
       vert_move = 0;
    elseif (value_below < value_right) && (value_left < value_right)
        horiz_move = 1;
        vert_move = 0;
    elseif (value_right < value_below) && (value_left < value_below)
        vert_move = 1;
        horiz_move = 0;
    end
    Index_Miner_X = Index_Miner_X + horiz_move;
    Index_Miner_Y = Index_Miner_Y + vert_move; 
    else
       Index_Miner_X = Index_Miner_X+1;
       Index_Miner_Y = Index_Miner_Y+1;
    end
    if Index_Miner_Y+vert_move > 1 || Index_Miner_X+horiz_move > 1
Lith(Index_Miner_Y+vert_move,Index_Miner_X+horiz_move) = Miner;
Miner = 0;
    else
        Index_Miner_Y = 1;
        Index_Miner_X = 1; 
    end
%%Plot
figure(1)
clf
image(Lith,'CDataMapping','Scaled')
colorbar
pause(0.1)
end
