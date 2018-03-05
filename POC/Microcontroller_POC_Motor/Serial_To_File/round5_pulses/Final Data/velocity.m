function [x] = velocity(Vol, Tol, M, N)
x = zeros(1,(N - M+1));
for k = (M:1:N)
    x(k-M+1) = Vol(k)/Tol(k);
end