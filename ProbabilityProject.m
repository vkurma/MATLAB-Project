fileName = 'data.mat';
data = importdata(fileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mu11,s11] = normfit(data.F1((1:100),1));
[mu12,s12] = normfit(data.F1((1:100),2));
[mu13,s13] = normfit(data.F1((1:100),3));
[mu14,s14] = normfit(data.F1((1:100),4));
[mu15,s15] = normfit(data.F1((1:100),5));

totalCorrects = 0;
totalCount = 0;
for row = (101:1000)
    for column = (1:5)
        p = normpdf(data.F1(row,column),[mu11,mu12,mu13,mu14,mu15],[s11,s12,s13,s14,s15]);
        totalCount = totalCount+1;
        if(find(p == max(p)) == column)
            totalCorrects = totalCorrects+1;
        end
    end
end

F1Accuracy = totalCorrects/totalCount;
display(F1Accuracy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Z1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%z1 = normalize(data.F1,"zscore");
z1 = data.F1;
[totalMean1,totalSD1] = normfit(z1(:,1));

for row = (1:1000)
    [totalMean,totalSD] = normfit(z1(row,:));
    z1(row,:) = (z1(row,:)-totalMean)/totalSD;
end

[mu21,s21] = normfit(z1((1:100),1));
[mu22,s22] = normfit(z1((1:100),2));
[mu23,s23] = normfit(z1((1:100),3));
[mu24,s24] = normfit(z1((1:100),4));
[mu25,s25] = normfit(z1((1:100),5));

totalCorrects = 0;
totalCount = 0;
for row = (101:1000)
    for column = (1:5)
        p = normpdf(z1(row,column),[mu21,mu22,mu23,mu24,mu25],[s21,s22,s23,s24,s25]);
        totalCount = totalCount+1;
        if(find(p == max(p)) == column)
            totalCorrects = totalCorrects+1;
        end
    end
end

Z1Accuracy = totalCorrects/totalCount; 
display(Z1Accuracy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mu31,s31] = normfit(data.F2((1:100),1));
[mu32,s32] = normfit(data.F2((1:100),2));
[mu33,s33] = normfit(data.F2((1:100),3));
[mu34,s34] = normfit(data.F2((1:100),4));
[mu35,s35] = normfit(data.F2((1:100),5));

totalCorrects = 0;
totalCount = 0;
for row = (101:1000)
    for column = (1:5)
        p = normpdf(data.F2(row,column),[mu31,mu32,mu33,mu34,mu35],[s31,s32,s33,s34,s35]);
        totalCount = totalCount+1;
        if(find(p == max(p)) == column)
            totalCorrects = totalCorrects+1;
        end
    end
end

F2Accuracy = totalCorrects/totalCount;
display(F2Accuracy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ Z1
%   F2 ] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalCorrects = 0;
totalCount = 0;

s41 = [s21 0;
       0 s31];
   
s42 = [s22 0;
       0 s32];
   
s43 = [s23 0;
       0 s33];
   
s44 = [s24 0;
       0 s34];
   
s45 = [s25 0; 
        0 s35];

means = [[mu21 mu31], [mu22 mu32], [mu23 mu33], [mu24 mu34], [mu25 mu35]];
sigmas = [s41,s42,s43,s44,s45];
%p = mvnpdf([z1(row,column) data.F2(row,column)],[[0 mu1];[0 mu2];[0 mu3];[0 mu4];[0 mu5]],[s11,s12,s13,s14,s15]);
for row = (101:1000)
    for column = (1:5)
        p = []; 
        for i = 1:5
            p = [p; mvnpdf([z1(row,column) data.F2(row,column)], means(:,[2*i-1,2*i]), sigmas(:,[2*i-1,2*i]))];    
        end
        totalCount = totalCount+1;
        if(find(p == max(p)) == column)
            totalCorrects = totalCorrects+1;
        end
    end
end

Z1F2Accuracy = totalCorrects/totalCount;
display(Z1F2Accuracy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ F1
%   F2 ] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalCorrects = 0;
totalCount = 0;

s51 = [s11 0;
       0 s31];
   
s52 = [s12 0;
       0 s32];
   
s53 = [s13 0;
       0 s33];
   
s54 = [s14 0;
       0 s34];
   
s55 = [s15 0; 0 s35];

means = [[mu11 mu31], [mu12 mu32], [mu13 mu33], [mu14 mu34], [mu15 mu35]];
sigmas = [s51,s52,s53,s54,s55];
%p = mvnpdf([z1(row,column) data.F2(row,column)],[[0 mu1];[0 mu2];[0 mu3];[0 mu4];[0 mu5]],[s11,s12,s13,s14,s15]);
for row = (101:1000)
    for column = (1:5)
        p = []; 
        for i = 1:5
            p = [p; mvnpdf([z1(row,column) data.F2(row,column)], means(:,[2*i-1,2*i]), sigmas(:,[2*i-1,2*i]))];    
        end
        totalCount = totalCount+1;
        if(find(p == max(p)) == column)
            totalCorrects = totalCorrects+1;
        end
    end
end

F1F2Accuracy = totalCorrects/totalCount;
display(F1F2Accuracy);

scatter(z1(:,1), data.F2(:,1));
hold on 
scatter(z1(:,2), data.F2(:,2));
hold on 
scatter(z1(:,3), data.F2(:,3));
hold on 
scatter(z1(:,4), data.F2(:,4));
hold on 
scatter(z1(:,5), data.F2(:,5));
legend("C1", "C2", "C3", "C4", "C5")
xlabel("Z1")
ylabel("F2")

figure
scatter(data.F1(:,1), data.F2(:,1));
hold on 
scatter(data.F1(:,2), data.F2(:,2));
hold on 
scatter(data.F1(:,3), data.F2(:,3));
hold on 
scatter(data.F1(:,4), data.F2(:,4));
hold on 
scatter(data.F1(:,5), data.F2(:,5));
legend("C1", "C2", "C3", "C4", "C5")
xlabel("F1")
ylabel("F2")

figure
cases = categorical({'(X = F1)', '(X = Z1)', '(X = F2)', '(X = [Z1 F2])','(X = [F1 F2])'});
accuracy = [F1Accuracy Z1Accuracy F2Accuracy Z1F2Accuracy, F1F2Accuracy];
bar(cases, accuracy)


