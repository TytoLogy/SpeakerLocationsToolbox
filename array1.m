% speaker map

close all
clear all

% first, define some variables

Nmax = 144;
SpkrDia = 2.8;  % speaker diameter in inches
Diameter = 60; % sphere diameter in inches
Radius = Diameter / 2;     % radius of sphere in inches
MaxEl = 30;
MaxAz = 30;
AzInterval = 10;
ElInterval = 10;

% Arc is 180 degrees
Arc = 210;

% length of arc on sphere = r * angle, where angle is measured in radians.
ArcLen = Radius * deg2rad(Arc);
SpkrAngle = rad2deg(SpkrDia / Radius);
MaxSpkr = ArcLen / SpkrDia;
NAzSpkr = Arc / AzInterval;

% This section demonstrates an "angularly uniform" distribution of speaker
% locations.
[X, Y, Z] = sphere;
X = Radius * X;
Y = Radius * Y;
Z = Radius * Z;
surf(X, Y, Z);
axis equal;
colormap(gray);
xlabel('X'); ylabel('Y'); zlabel('Z');
view([145 30])

elevation = MaxEl:-ElInterval:-MaxEl;
n_el = length(elevation);
azimuth = MaxAz:-AzInterval:-MaxAz;
n_az = length(azimuth);
cnt = 0;
az_step = 1;


for el = 1:n_el 
% 	if elevation(el) < 90 % to keep the count accurate, avoid re-plotting the 0 and 180 az. speakers
% 		az_start = 2;
% 		az_end = n_az - 1;
% 	else
% 		az_start = 1;
% 		az_end = n_az;
% 	end
	if abs(elevation(el)) == 80
		az_step = 2;
	else
		az_step = 1;
	end
	az_start = 1;
	az_end = n_az;

	for az = az_start:az_step:az_end
		cnt = cnt + 1;
		azs(cnt) = azimuth(az);
		els(cnt) = elevation(el);
	end
end

TotalSpeakers = cnt;

for cnt = 1:TotalSpeakers
	[x(cnt), y(cnt), z(cnt)] = sph2cart(deg2rad(azs(cnt)), deg2rad(els(cnt)), Radius);
end

hold on
plot3(x, y, z, 'rO')
hold off

figure

plot(azs, els, '.')


sprintf('Speaker Count = %d', TotalSpeakers)

