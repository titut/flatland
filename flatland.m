addpath("Neato\");

clear;

syms x y
f(x,y) = 8 * exp(-1.5*(x+y-0.75)^2 - 0.5 * (x-y - 0.75)^2) + 6 * exp(-1 * (x + 0.75).^2 - (y + 0.25).^2);
v = [x y];
grad = gradient(f, v);

XLIN = linspace(-1.25, 1.25);
YLIN = linspace(-0.5, 0.5);
[X,Y] = meshgrid(XLIN, YLIN);
Z = 8 * exp(-1.5*(X+Y-0.75).^2 - 0.5 * (X - Y - 0.75).^2) + 6 * exp(-1 * (X + 0.75).^2 - (Y + 0.25).^2);

position = [.2, -.3];
cur_angle = pi/2;
angular_speed = pi/15;
linear_speed = 0.05;
d = 0.245;
wheel_angular_speed = (angular_speed * 0.245)/2;

lambda = 0.02;
delta = 1;

neatov2.connect();
neatov2.setPositionAndOrientation(position(1), position(2), cur_angle);
neatov2.setFlatlandContours(X, Y, Z);

f = figure;
neatov2.plotSim();

while abs(norm(grad(position(1), position(2)))) > 1
    gradient_at_pos = grad(position(1), position(2));
    
    gradient_angle = atan(gradient_at_pos(2)/gradient_at_pos(1));
    change_angle = gradient_angle - cur_angle;
    cur_angle = gradient_angle;
    time_to_rotate = change_angle/angular_speed;
    rotate_direction = time_to_rotate/abs(time_to_rotate);
    neatov2.driveFor(abs(time_to_rotate), rotate_direction * -wheel_angular_speed,rotate_direction * wheel_angular_speed, true);
    
    neatov2.plotSim();
    
    change_position = double(gradient_at_pos) * lambda;
    position = position + change_position';
    time_to_drive = norm(change_position)/linear_speed;
    neatov2.driveFor(time_to_drive, linear_speed, linear_speed, true);
    neatov2.plotSim();
end