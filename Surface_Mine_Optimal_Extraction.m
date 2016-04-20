%%2D Surface Mine Optimal Extraction
%Final project 
%Marko Visnjic for GEOL 5700

% Describes a single surface miner progressing through a surface mine with
% a randomly generated and distributed lithology. The miner will start at
% the highest value block and search to go further down in a path that will
% optimize the value obtained by the miner.

% Rules:
% 1. The miner can only move down left and right
% 2. At first the miner will look at only which block is greater in it's
%    immediate vacinity. 
% 3. When the miner mines a block it's value will be set 
% to zero.
% 4. pit depth can only be 2 units deep before returning to the surface.

%%Initialize Parameters

cut_off_grade = 0.3;
Depth_Limit = 3;
min_Depth = 1;
% X Boundary
xmax = 200;

%Y Boundary
ymax = 200;

%%Algorithm
%Layer search
Lith = rand(ymax,xmax);
filter = ones(4,4);
Lith = filter2(filter,Lith);

%Lith(Lith<(cut_off_grade)) = 0;

summation = (1:xmax-1);
for i=1:xmax-1
    summation(i) = sum(Lith(1:3,i));
end
[max_value,Index_Miner_X]= max(summation);

% [T3_Max,Index_Miner_X]=Layer_Search_Type_2(cut_off_grade);
Index_Miner_Y = 1;
imax = xmax.*ymax;

jmax = ymax;
% Lith(Index_Miner_Y,Index_Miner_X);
%Start the Miner
Miner = Lith(Index_Miner_Y,Index_Miner_X);
for i=1:imax
    
    %Find the shallowest Y value in the mine
    for j = 1:jmax-1
        while min_Depth < 0
    min_Depth(1) = find(Lith(j,:)>0);
        end
    end
    
    if Index_Miner_Y <= Depth_Limit %If miner Y val <= depth limit
        Lith(Index_Miner_Y,Index_Miner_X) = Miner;
        Miner = 0;
    if Index_Miner_X > 1 || Index_Miner_Y > 1 %Limit the miner to not travel beyond bounds
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
    else %Bounding the miner to the boundaries
       Index_Miner_X = Index_Miner_X+1;
       Index_Miner_Y = Index_Miner_Y+1;
    end
    if Index_Miner_Y+vert_move > 1 || Index_Miner_X+horiz_move > 1 %Incremeting the miner
Lith(Index_Miner_Y+vert_move,Index_Miner_X+horiz_move) = Miner;
Miner = 0;
    else
        Index_Miner_Y = 1;
        Index_Miner_X = 1; 
    end
    else
        Index_Miner_Y = min_Depth; 
    end
%%Plot
figure(1)
clf
image(Lith,'CDataMapping','Scaled')
colorbar
pause(0.1)
end
