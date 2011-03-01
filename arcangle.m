function theta = arcangle(d, r)
%FUNCTION THETA = ARCANGLE(D, R)
%
% D = distance between two points
% R = radius of sphere
% for theta to be in radians, units of D and R must be the same
%
% returns 
% THETA = angle (N X 1), in radians

% Sharad Shanbhag
% sshanbha@aecom.yu.edu
% 11/22/05


% and the great circle distance between the two
theta = d ./ r;
