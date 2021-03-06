%Pattern Recognition Coursework 1
close all
clear
clc

%data partitioning
load('face(1).mat');
ntotal = max(l); %maximum value in l
tr_data = []; te_data=[]; tr_label=[]; te_label = [];
ntr = 1; nte = 1;
for i = 1:max(l) %cover all the photos
        tmp = find(l==i);
        tr_data = horzcat(tr_data, X(:,tmp(1:8)));
        tr_label = horzcat(tr_label, ones(1, length(tmp(1:8)))*ntr);
        ntr = ntr + 1;
            
        te_data = horzcat(te_data, X(:,tmp(9:10)));
        te_label = horzcat(te_label, ones(1,length(tmp(9:10)))*nte);
        nte = nte +1;
        
end

[V1, D1, xbar] = PCA(tr_data, tr_label, 50, 208, te_data, te_label, 104);

[V2, D2, ~] = PCA2(tr_data, 50);

M = [10 25 50 100 200];
[faces, recon_e] = faceReconst(xbar, X(:,208), V2, M);

[altAcc1, altFail1] = altRecog(te_data, te_label, tr_data, tr_label, 1);
[altAcc2, altFail2] = altRecog(te_data, te_label, tr_data, tr_label, 2);
[altAcc3, altFail3] = altRecog(te_data, te_label, tr_data, tr_label, 4);
[altAcc4, altFail4] = altRecog(te_data, te_label, tr_data, tr_label, 7);

[NNAcc1, NNFail1] = NNRecog(tr_data, tr_label, 25, te_data, te_label, V2, xbar);
[NNAcc2, NNFail2] = NNRecog(tr_data, tr_label, 50, te_data, te_label, V2, xbar);
[NNAcc3, NNFail3] = NNRecog(tr_data, tr_label, 100, te_data, te_label, V2, xbar);
[NNAcc4, NNFail4] = NNRecog(tr_data, tr_label, 200, te_data, te_label, V2, xbar);
[NNAcc5, NNFail5] = NNRecog(tr_data, tr_label, 400, te_data, te_label, V2, xbar);
