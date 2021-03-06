graf_amp = zeros(5, 10);

pathList = ['0.1'; '0.2'; '0.4'; '0.5'; '0.7'; '0.8'; '1.0'; '1.3'; '1.6'; '1.9'];
ampList = [0.131; 0.280; 0.427; 0.551; 0.729; 0.823; 1.047; 1.305; 1.612; 1.952];
factorList = [20; 40; 100];

for graf_num=1:10
    display(['graf ' int2str(graf_num)])
    load(['../data/3Hz/' pathList(graf_num, :) '_points.mat'], 'points') 

    normalize

    filteredBase = pointsNorm(:, 3:4, :);

    filteredBase = permute(filteredBase, [3 2 1]);
    filtered = ideal_bandpassing(filteredBase, 3, 2.5, 3.5, 185/3);
    filtered = permute(filtered, [3 2 1]);

    sf_filter

    for graf_offset=1:3

        factor = factorList(graf_offset);
        display(['factor ' int2str(factor)])
        magnif

        amp_val = ampList(graf_num, :);

        grafs
    end
end