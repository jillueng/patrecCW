function [euDist, minDistIdx] = NNRecog(tr_data, tr_label, M, te_data, te_label, nC, V_sorted, avg_t)

    %face recognition: Nearest Neighbor Classification
    im_t = te_data(:,nC);
    w_t = [1,M];
    for i=1:M
        w_t(i) = dot((im_t - avg_t),V_sorted(:,i));
    end

    euDist = [1, size(tr_data, 1)];
    for i=1:size(tr_data, 2) % i = image index in training data
        w_n = [];
        for j=1:M %j = eigenvector index in sorted matrix/number of weights
            w_n(j) = dot(tr_data(:,i) - avg_t ,V_sorted(:,j));
        end %completed weights vector for one training image
        %create vector of dists between test image weights and each training image weights
        euDist(i) = pdist2(w_t, w_n);             
    end
    [~, minDistIdx] = min(euDist);
    %minDistIdx refers to the index of the 'closest' image match from the training data

    %display test image used and the closest match from the training data
    im_t = reshape(im_t, [56,46]);
    im_t = imrotate(im_t.',270); 
    im_m = reshape(tr_data(:,minDistIdx), [56, 46]);
    im_m = imrotate(im_m.',270);

    figure(5);
    subplot(1,2,1), image(im_t); 
    title(['Testing Image, Identity #', num2str(te_label(1,nC))])
    subplot(1,2,2), image(im_m); 
    title(['Closest Match, Identity #', num2str(tr_label(1, minDistIdx))])

end