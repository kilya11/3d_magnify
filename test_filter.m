samplingRate = 5000;

% Signal parameters:
f = [ 10 40 100  ];      % frequencies   
M = 500;                        % signal length 

frames = 10;
x = zeros(frames, M); % pre-allocate 'accumulator'
n = 0:(M-1);    % discrete-time grid 
for frame=1:frames
    % Generate a signal by adding up sinusoids:
    for fk = f; 
        x(frame, :) = x(frame, :) + sin(2*pi*n*fk/samplingRate); 
    end
    x(frame, :) = x(frame, :) + 3;
end

filtered = ideal_bandpassing(x, 2, 30, 50, samplingRate);
plot(n, x(1, :), 'k');
hold all;
plot(n, filtered(1, :), '--k');
xlabel('t')
ylabel('f(t)')
legend('Signal', 'Filter')