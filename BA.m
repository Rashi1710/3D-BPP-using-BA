%BA 

%% Initialization

empty_bee.Position=[];
empty_bee.Cost=[];
empty_bee.Sol=[];

totaltime = 0;
for run = 1:runtimes
% Create Population Matrix (Array)
bee=repmat(empty_bee,nScoutBee,1);
totaltime = 0;
% Create New Solutions
for i=1:nScoutBee
    bee(i).Position= rand(1, 2*n);
    [bee(i).Cost, bee(i).Sol]= evaluate(bee(i).Position, bin, boxes, mindim, minvol);
end

% Sort
[~, SortOrder]=sort([bee.Cost]);
bee=bee(SortOrder);

% Update Best Solution Ever Found
BestSol=bee(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%% BA Main Loop
tic
for it=1:MaxIt
     % Elite Sites
    for i=1:nEliteSite
        
        bestnewbee.Cost=inf;
        
        for j=1:nEliteSiteBee
            newbee.Position= PerformBeeDance(bee(i).Position);
            [newbee.Cost, newbee.Sol]=evaluate(newbee.Position, bin, boxes, mindim, minvol);
            if newbee.Cost<bestnewbee.Cost
                bestnewbee=newbee;
            end
        end

        if bestnewbee.Cost<bee(i).Cost
            bee(i)=bestnewbee;
        end
        
    end
    
    % Selected Non-Elite Sites
    for i=nEliteSite+1:nBestSite
        
        bestnewbee.Cost=inf;
        
        for j=1:nBestSiteBee
            newbee.Position= PerformBeeDance(bee(i).Position);
            [newbee.Cost, newbee.Sol]=evaluate(newbee.Position, bin, boxes, mindim, minvol);;
            if newbee.Cost<bestnewbee.Cost
                bestnewbee=newbee;
            end
        end

        if bestnewbee.Cost<bee(i).Cost
            bee(i)=bestnewbee;
        end
        
    end
    
    % Non-Selected Sites
    for i=nBestSite+1:nScoutBee
        bee(i).Position= rand(1,2*n);
        [bee(i).Cost, bee(i).Sol]=evaluate(bee(i).Position, bin, boxes, mindim, minvol);
    end
   
    
    % Sort
    [~, SortOrder]=sort([bee.Cost]);
    bee=bee(SortOrder);
    
    % Update Best Solution Ever Found
    BestSol=bee(1);
    
     % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
   
end
time = toc;
totaltime = totaltime + time;
%fff(run) = BestCost(it);
Best(run) = BestSol;
end
disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
        name = ['Result',num2str(MaxIt),'nScoutBee',num2str(nScoutBee)];
        %ave_fff = sum(fff(1:runtimes))/runtimes;
        ave_time = totaltime/runtimes;
        save(name,'totaltime','ave_time','Best');        


%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
