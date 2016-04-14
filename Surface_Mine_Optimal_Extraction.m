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

%Initial Starting Grade

grade_init = 0.9;

% X Array
dx = 1;
xmax = 100;
x = 1:dx:xmax;

%Y Array
dy = 1;
ymax = 100;
y = 1:dy:100;

%% Lithology
%Lithological Matrix of Random Numbers
% rand_Control = rng(seed);
% rng(rand_Control);
Lith = rand(xmax,ymax);

%%Algorithm

%Start the Miner

%Find the locations of the largest ore values in the top 3 layers
greatest_starting = find(Lith(:,1)>grade_init);
greatest_secondary = find(Lith(:,2)>grade_init);
greatest_tertiary = find(Lith(:,3)>grade_init);

%Find the highest indices of the top three layers
 Layer_1_Lith_Val = 0;
 Layer_1_Lith_Val_Next = 0;

for i=1:length(greatest_starting)
   if Layer_1_Lith_Val < Layer_1_Lith_Val_Next
    Layer_1_Lith_Val = Lith(greatest_starting(i):1);
    Layer_1_Lith_Val_Next = Lith(greatest_starting(i+1):1);
   else
       index_1 = greatest_starting(i);
   end
end

Layer_2_Lith_Val = 0;
Layer_2_Lith_Val_Next = 0;
for j=1:length(greatest_secondary)
   if Layer_2_Lith_Val < Layer_2_Lith_Val_Next
    Layer_2_Lith_Val = Lith(greatest_secondary(j):1);
    Layer_2_Lith_Val_Next = Lith(greatest_secondary(j+1):1);
   else
       index_2 = greatest_secondary(j);
   end
end

Layer_3_Lith_Val = 0;
Layer_3_Lith_Val_Next = 0;
for k=1:length(greatest_tertiary)
   if Layer_3_Lith_Val < Layer_3_Lith_Val_Next
    Layer_3_Lith_Val = Lith(greatest_tertiary(k):1);
    Layer_3_Lith_Val_Next = Lith(greatest_tertiary(k+1):1);
   else
       index_3 = greatest_secondary(k);
   end
end

%%Plot
% figure(1)
% clf
% image(Lith,'CDataMapping','Scaled')
% colorbar
