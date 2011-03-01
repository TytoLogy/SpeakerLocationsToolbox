function [d, theta] = arcdistance(a, b, r)
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

% convert the two points to Cartesian coordinates
[ac(:, 1), ac(:, 2), ac(:, 3)] = sph2cart(a(:, 1), a(:, 2), r);
[bc(:, 1), bc(:, 2), bc(:, 3)] = sph2cart(b(:, 1), b(:, 2), r);

% compute the dot product between the two vectors
% and then compute the arccos to get the angle
t = acos(dot(ac, bc)/(norm(ac)*norm(bc)));

% and the great circle distance between the two
d = r .* t;

if nargout > 1
	theta = t;
end
