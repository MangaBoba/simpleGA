%avg = zeros(20,3);
% parfor s = 1:25
%     shod = zeros(20,3);
% for i = 1:1:20
%   [val,step]= GA(i*0.05);
%   shod(i,:) = [i*0.05,val,step];
% end
%     avg = avg+shod;
% 
% end
% 
% avg=avg/25;
% avg(:,2) = round(avg(:,2),3);
% disp(avg);

%перебор численности популяций
pop = 10:10:120;
%перебор вероятностей кроссинговера
cc = 0.05:0.05:1;
[cc,pop] = meshgrid(cc,pop);

mv = zeros(size(cc,1),size(cc,2));
step_v = zeros(size(cc,1),size(cc,2));
mv_avg = zeros(size(cc,1),size(cc,2));
step_avg = zeros(size(cc,1),size(cc,2));

ccto =size(cc,2);
popto = size(pop,1);

for av = 1:1:5 %получаем усреденные значения по итогу 5 прогонов алгоритма
parfor pop_cord = 1:popto
   for cc_cord = 1:1:ccto
       [mv(pop_cord,cc_cord),step_v(pop_cord,cc_cord)] = GA(cc(cc_cord),0.005,pop(pop_cord));
   end    
end
mv_avg = mv_avg+mv;
step_avg = step_avg + step_v;
end

