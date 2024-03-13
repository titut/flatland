clear;

syms x y
f(x,y) = 8 * exp(-1.5*(x+y-0.75)^2 - 0.5 * (x-y - 0.75)^2) + 6 * exp(-1 * (x + 0.75).^2 - (y + 0.25).^2);
v = [x y];
grad = gradient(f, v);

XLIN = linspace(-1.25, 1.25);
YLIN = linspace(-0.5, 0.5);
[X,Y] = meshgrid(XLIN, YLIN);
Z = 8 * exp(-1.5*(X+Y-0.75).^2 - 0.5 * (X - Y - 0.75).^2) + 6 * exp(-1 * (X + 0.75).^2 - (Y + 0.25).^2);
contour(X, Y, Z, 15); hold on;
axis equal;

%first location

r = [.2, -.3];
lambda = 0.02;
delta = 1;

grad(r(end, 1), r(end, 2))

while abs(norm(grad(r(end, 1), r(end, 2)))) > 0.05
    row_len = size(r, 1);
    grad_sym = grad(r(end, 1), r(end, 2));
    r(row_len+1, :) = r(row_len, :) + lambda * grad_sym';
    lambda = lambda * delta;
end

scatter(r(:, 1), r(:, 2), "filled", "r");

r = [1.05, .3];

while abs(norm(grad(r(end, 1), r(end, 2)))) > 0.05
    row_len = size(r, 1);
    grad_sym = grad(r(end, 1), r(end, 2));
    r(row_len+1, :) = r(row_len, :) + lambda * grad_sym';
    lambda = lambda * delta;
end

scatter(r(:, 1), r(:, 2), "filled", "b");

r = [-.4, .3];

while abs(norm(grad(r(end, 1), r(end, 2)))) > 0.05
    row_len = size(r, 1);
    grad_sym = grad(r(end, 1), r(end, 2));
    r(row_len+1, :) = r(row_len, :) + lambda * grad_sym';
    lambda = lambda * delta;
end

scatter(r(:, 1), r(:, 2), "filled", "g");

r = [-1.05, .3];

while abs(norm(grad(r(end, 1), r(end, 2)))) > 0.05
    row_len = size(r, 1);
    grad_sym = grad(r(end, 1), r(end, 2));
    r(row_len+1, :) = r(row_len, :) + lambda * grad_sym';
    lambda = lambda * delta;
end

scatter(r(:, 1), r(:, 2), "filled", "m");