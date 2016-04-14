function [index_1,index_2,index_3] = Layer_Search(grade_init);
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
disp(index_1)

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
disp(index_2)

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
disp(index_3)
end

