clear all;
close all;
clc;
figure
colormap gray;
if 0
    t=0:0.01:2*pi;
    plot(sin(t),'k'),hold on
    %plot(sin(2*t),'g','LineWidth',2),
    plot(sin(3*t),'--k'),
    xlabel('t');
    ylabel('sin({\omega}t)');
    %grid on;
    legend('{\omega} = 1', '{\omega} = 3')
end

if 0
    t_discrete  =0:0.5:2*pi;
    y= sin(3*t_discrete);

    imagesc(y)
end

row=200;
col=200;
x  =0:(2*pi/(col-1)):2*pi;
y  =0:(2*pi/(row-1)):2*pi;
for k=3:0.2:10
    %k=2;
    coskx  = sin(k*x);
    cosky  = sin(k*y);
    cosval = zeros(size(y,2),size(x,2));

    for i=1:size(y,2)
        for j=1:size(x,2)
            cosval(i,j) = coskx(j)*coskx(i);       
        end
    end

    imshow(cosval,[])
    drawnow;
    pause(0.1);
    return
end
figure, plot(x,coskx,'LineWidth',3)
hleg1 = legend('cos(x)');
grid on;