k = 50*111+50;
k = 10*111+10;

k = 80*171+80;
k = 150*171+100;
x = pointsNorm(:, 3, k);

x2 = points2(:, 3, k);

if 1
    plot(x, 'k')
    hold all;

    plot(x2, '--k');

    xlabel('Frame')
    ylabel('x Koordinate')
    legend('original', '50x');
end

%graf_num = 10;
graf_amp(1, graf_num) = amp_val;
graf_amp(2, graf_num) = std(x);
graf_amp(2+graf_offset, graf_num) = std(x2);
return
graf_amp = zeros(3, 10);

plot(graf_amp(1, :), graf_amp_center(2,:), 'k')
hold all;
plot(graf_amp(1, :), graf_amp_center(4,:), '.--k')
plot(graf_amp(1, :), graf_amp(4,:), '--k')
xlabel('Amplitude, V')
ylabel('Standartabweichung')
legend('original', '50x Membran', '50x Rand')

figure
x = filtered_stack(k, 1, :);
x = squeeze(x);
plot(x, 'k')