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
% 4. pit depth can only be Depth_Limit units deep before returning to the surface.

%%Initialize Parameters
% X Boundary
xmax = 50;

%Y Boundary
ymax = 50;

Depth_Limit = 3; %How deep the miner can go without collapsing the pit 
min_Depth = 1; %Shallowest soil depth value


%%Algorithm

%Defining Lithology
Lith = rand(ymax,xmax); %Generate a random lithology
filter = ones(3,6); %Corrolate it with a filter
Lith = filter2(filter,Lith); %Final Lithology

%Sum the first three cells of every column to find the starting point with
%the greatest first three values
summation = (1:xmax-1);
for i=1:xmax-1
    summation(i) = sum(Lith(1:3,i));
end

[max_value,Index_Miner_X]= max(summation);

Index_Miner_Y = 1;
imax = xmax.*ymax;

jmax = ymax;

%Start the Miner
Miner = 0;

%Run the loop while there is still ore in the ground
while sum(Lith(:,:)) > 0
    
    %Find the shallowest Y value in the mine
    for j = 1:jmax-1
        while min_Depth < 0
    min_Depth = find(Lith(j,:)>0,1,'last');
        end
    end
   
if sum(Lith(min_Depth,:) > 0 )
  
    if Index_Miner_Y <= Depth_Limit %If miner Y val <= depth limit
        Lith(Index_Miner_Y,Index_Miner_X) = Miner;
        Miner = 0;
    if Index_Miner_X > 1 && Index_Miner_X < xmax && Index_Miner_Y < ymax %Limit the miner to not travel beyond bounds
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
    if Index_Miner_Y == 1 || Lith(Index_Miner_Y-1,Index_Miner_X+horiz_move)==0 
       
       if value_below > 0 || value_left > 0 || value_right > 0 
        Index_Miner_X = Index_Miner_X + horiz_move;
        Index_Miner_Y = Index_Miner_Y + vert_move;
       else
        Index_Miner_X = find(Lith(Index_Miner_Y,:),1,'first');
        Index_Miner_Y = find(Lith(:,Index_Miner_X),1,'first');     
       end
    else
        Index_Miner_Y = Index_Miner_Y-1;
    end
    safe_catch_value = find(Lith(min_Depth,:),1,'last');
    else %Bounding the miner to the boundaries
       safe_catch_value = find(Lith(min_Depth,:),1,'last'); 
       Index_Miner_X = safe_catch_value;
       Index_Miner_Y = min_Depth;
    end
    else
        Index_Miner_Y = min_Depth;
        summation1 = (1:xmax-1);
for eta=1:xmax-1
    summation1(eta) = sum(Lith(min_Depth:Depth_Limit,eta));
end
[max_value2,Index_Miner_X]= max(summation1);
        
    end
else
    
    min_Depth = min_Depth+1;
    Index_Miner_Y = min_Depth;
    summation2 = (1:xmax-1);
    for gamma=1:xmax-1
    summation2(gamma) = sum(Lith(min_Depth:Depth_Limit,gamma));
    end
[max_value3,Index_Miner_X]= max(summation2);
Depth_Limit = Depth_Limit+1;
end

%%Plot
figure(1)
clf
image(Lith,'CDataMapping','Scaled')
colorbar
drawnow
% pause(0.1)
end
