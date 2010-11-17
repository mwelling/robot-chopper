function [sum] = integral(value,prevsum, min, max, dt)
sum = prevsum + value;
if sum > max
   sum = max;
elseif sum < min
   sum = min;
end
sum = sum * dt;

