% function [d, theta] = arcdistance(a, b, r)
%FUNCTION [D, THETA] = ARCDISTANCE(A, B, R)
%
% A = [az, el] of first point, in radians, (N X 2)
% B = [az, el] of second point, in radians, (N X 2]
% R = radius of circle, (N X 1)
%
% returns 
% D = distance (N X 1)
% THETA = angle (N X 1)

% Sharad Shanbhag
% sshanbha@aecom.yu.edu
% 10/20/05

a = [0 0];
b = [45 0];
r = 1;


% convert to radians
ar = deg2rad(a);
br = deg2rad(b);

% convert the two points to Cartesian coordinates
[ac(:, 1), ac(:, 2), ac(:, 3)] = sph2cart(ar(:, 1), ar(:, 2), r);
[bc(:, 1), bc(:, 2), bc(:, 3)] = sph2cart(br(:, 1), br(:, 2), r);

% compute the dot product between the two vectors
% and then compute the arccos to get the angle
t = acos(dot(ac, bc)/(norm(ac)*norm(bc)));

% and the great circle distance between the two
d = r .* t;

a2 = [0 0];
b2 = [45 0];
[d1, t2] = arcdistance(deg2rad(a2), deg2rad(b2), r)

