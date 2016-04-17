
%Layer_Search searches the top 3 layers of the ore body to determine the
%best initial path given a minimum starting ore grade 
%   Detailed explanation goes here
%Find the locations of the largest ore values in the top 3 layers

%  grade_init = 0.9;

% X Array
xmax = 100;

%Y Array
ymax = 100;


%% Lithology
%Lithological Matrix of Random Numbers

Lith = rand(xmax,ymax);

% Find the highest value indices of the top three layers

summation = (1:99);
for i=1:xmax-1
    summation(i) = sum(Lith(1:3,i));
end
[max_value,Index_1]= max(summation);
