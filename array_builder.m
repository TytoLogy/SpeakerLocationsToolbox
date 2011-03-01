% speaker map

% first, define some variables

N = 120;
SpkrDia = 2.8;  % speaker diameter in centimeters
Diameter = 1.5 * 100; % sphere diameter in centimeters
Radius = Diameter / 2;     % radius of sphere in centimeters

% Arc is 180 degrees
Arc = 180;

% length of arc on sphere = r * angle, where angle is measured in radians.
ArcLen = Radius * deg2rad(Arc);

SpkrAngle = rad2deg(SpkrDia / Radius);
MaxSpkr = ArcLen / SpkrDia;

SpkrInterval = 15;
NSpkr = Arc / SpkrInterval;


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

hold on
elevation = 90:-SpkrInterval:-90;
n_el = length(elevation);
azimuth = 0:SpkrInterval:180;
n_az = length(azimuth);
cnt = 0;

for el = 1:n_el 
	if elevation(el) < 90 % to keep the count accurate, avoid re-plotting the 0 and 180 az. speakers
		az_start = 2;
		az_end = n_az - 1;
	else
		az_start = 1;
		az_end = n_az;
	end
	for az = az_start:az_end
		cnt = cnt + 1;
		azs(cnt) = azimuth(az);
		els(cnt) = elevation(el);
		[x(cnt), y(cnt), z(cnt)] = sph2cart(deg2rad(azs(cnt)), deg2rad(els(cnt)), Radius);
		plot3(x(cnt), y(cnt), z(cnt), 'rO')
	end
end
hold off

% collect the angles into an array
% the spec for the angles matrix is a bit odd but it makes sense:
% elevations are according to rows, azimuths to columns. 
% angles = zeros(n_el, n_az, 2);
for el = 1:n_el 
	for az = 1:n_az
	angles(el, az, 1) = elevation(el); % 1st slice of matrix contains elevations
	angles(el, az, 2) = azimuth(az);   % 2nd slice of matrix contains azimuths
	end
end

% compute the arc-length distances between the points

% first, set up some zero arrays to hold the data.
el_diff = zeros(n_el-1, 2);
az_diff = zeros(n_el, 2);

for i = 1:n_el-1
	a = deg2rad([angles(i, 1, 2) angles(i, 1, 1)]);
	b = deg2rad([angles(i+1, 1, 2) angles(i+1, 1, 1)]);
	[el_diff(i, 1), el_diff(i, 2)] = arcdistance(a, b, Radius);
	el_diff(i, 2) = rad2deg(el_diff(i, 2));
end

for i = 1:n_el
	a = deg2rad([angles(i, 1, 2) angles(i, 1, 1)]);
	b = deg2rad([angles(i, 2, 2) angles(i, 2, 1)]);
 	[az_diff(i, 1), az_diff(i, 2)] = arcdistance(a, b, Radius);
	az_diff(i, 2) = rad2deg(az_diff(i, 2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now, an arclength-equal distribution.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SpkrRadius = SpkrDia / 2;
InterSpkrSep = 1; 
SpkrDist = SpkrDia + InterSpkrSep;


% This is the minimum distance between speaker centers
MinStepAng = rad2deg(arcangle(SpkrDia, Radius));

% compute the angle stepsize
StepAng = rad2deg(arcangle(SpkrDist, Radius));



% loop through the elevations



