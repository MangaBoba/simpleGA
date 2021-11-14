function [value,step] = GA(cc,mc,ps)
%[максимум, поколение] (вероятность кроссинговеа,мутации, числ.популяции)
max_size = ps;
start_size = max_size;
crossover_chance = cc;
mutation_chance = mc;

nochange = 0;


prev_generation = randi([0,1],start_size,15);
%next_generation;

F = @(x) cos(2*x)/abs(x-2);

x1 = -10:0.01:10;
y1 = zeros(size(x1));
for i =1:1:size(x1,2)
    y1(i)=F(x1(i));
end

by = zeros(1,100);

for generation = 1:100
    
    %disp(size(prev_generation,1));
    
   clf
   hold on
   plot(x1,y1);
   a1 = bi2de(prev_generation).';
   a2 = F(bi2de(prev_generation).');
%    
   v = ((bi2de(prev_generation)*20/32767)-10);
   f = arrayfun(F,v);
   
   
%    
   plot(v,f, 'r*');
   cy= max(f);
   
   text(v(find(f==cy(1))),cy(1),'\downarrow max');
   hold off
    
   by(generation)=max(f); 
   
    
    
    %bin2dec(num2str(prev_generation(:,:)));
    %bin2dec(num2str(a(:,:)))./sum(bin2dec(num2str(a(:,:))));
    
    %отбор
    
    reproduction_pool = dec2bin(randsrc(size(prev_generation,1),1,[bin2dec(num2str(prev_generation(:,:))).'; (bin2dec(num2str(prev_generation(:,:)))./sum(bin2dec(num2str(prev_generation(:,:))))).']),15)-'0';
%          dem = size(reproduction_pool,2);
    
    
    
    %скрещивание
    intermid_generation = zeros(50,15);
    %число потомков
    cd = 0;
    for i=1:1:size(reproduction_pool,1)
        for j = i+1:1:size(reproduction_pool,1)
        if(bi2de(reproduction_pool(i,:)) ~= bi2de(reproduction_pool(j,:)))
            
            pos = randi([1 14],1,1);
            
            if 1 == randsrc(1,1,[1 0; crossover_chance, 1-crossover_chance])
                cd = cd+2;
                intermid_generation(cd-1,:) = [reproduction_pool(i,1:pos),reproduction_pool(j, pos+1:end)];
                intermid_generation(cd,:) = [reproduction_pool(j,1:pos), reproduction_pool(i, pos+1:end)];
                
            end
            
            
            
            
        end
        end
    end
    %prev_generation = unique(prev_generation,'rows');
    if ~isempty(intermid_generation)
    prev_generation = [prev_generation;intermid_generation];
    end
    
    %мутация
    for i=1:1:size(prev_generation,1)-1
        if 1 == randsrc(1,1,[1 0; mutation_chance 1-mutation_chance]) 
             mutatuion_pos = randi([1,15],1,1);
             prev_generation(i,mutatuion_pos) = ~prev_generation(i,mutatuion_pos);
        end
    end
    
    
    %редукция
    prev_generation = [arrayfun(F,((bi2de(prev_generation)*20/32767)-10)),prev_generation];
    prev_generation = sortrows(prev_generation,1);
    if(size(prev_generation,1) > max_size)
    prev_generation = prev_generation(end-max_size+1:end,2:end);
    else
    prev_generation = prev_generation(1:end,2:end);
    end
    %max of f(prev)
    
    
    if(generation>1)
    if(by(generation)==by(generation-1))
        if(nochange < 20)
        nochange = nochange+1;
        else
        value = by(generation);
        step = generation-1-nochange;
        break;
        end
    end
    end
    
    
    
    
    
    
    
end
   

%disp(max(f));
% 
plot(1:1:100,by);



end