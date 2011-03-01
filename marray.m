% speaker map

M = xlsread('speakermatrix2.xls');

NSpeakers = sum(sum(M))

azs = -100:10:100;
els =  80:-10:-80;

figure(1)
subplot(2, 1, 1)
hold on
nspkr = 0;
spkraz = [];
spkrel = [];
m_el = 1;
Maz = M;
Mel = M;

for el = 80:-10:-80
	m_az = 1;
	for az = -100:10:100
		if M(m_el, m_az) == 1
			nspkr = nspkr+1;
			plot(az, el, 'r.')
			spkraz(nspkr) = az;
			spkrel(nspkr) = el;
			Maz = az;
			Mel = el;
		else
			plot(az, el, 'w.')
		end
		m_az = m_az+1;
	end
	m_el = m_el+1;
end
hold off
ylim([-80 80])
grid

% now plot on a sphere
% first, define some variables

Nmax = 144;
SpkrDia = 2.8;  % speaker diameter in inches
Diameter = 60; % sphere diameter in inches
Radius = Diameter / 2;     % radius of sphere in inches
MaxEl = 80;
MaxAz = 100;
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
subplot(2, 1, 2)
[X, Y, Z] = sphere;
X = Radius * X;
Y = Radius * Y;
Z = Radius * Z;
s = surf(X, Y, Z);
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
sa = gca;
colormap(white)

hold on
[x, y, z] = sph2cart(deg2rad(spkraz), deg2rad(spkrel), Radius);
plot3(x, y, z, 'r.')
hold off
pa = gca;

set(sa, 'CameraTarget',  [1 0 0]);
set(sa, 'CameraPosition', [0 0 0]);
set(s, 'EdgeColor', [0.752941 0.752941 0.752941])
alpha('clear');


% This section demonstrates an "angularly uniform" distribution of speaker
% locations.
figure(2)
surf(X, Y, Z);
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
colormap(gray)

hold on
[x, y, z] = sph2cart(deg2rad(spkraz), deg2rad(spkrel), Radius);
plot3(x, y, z, 'ro')
hold off
view([145 30])


[Nel, Naz] = size(M);

els = 80:-10:-80;
Sloc = cell(Naz, 1);
sM = sum(M);

for i = 1:Naz
	Sloc{i} = zeros(sM(i), 1);
end


for az = 1:Naz
	j = 1;
	for el = 1:Nel
		if M(el, az) == 1
			Sloc{az}(j) = els(el);
			j = j+1;
		end
	end
end

centerx = 40;
centery = 40;
centerz = 44.5;
radius = 30;

delta_x = cell(Naz, 1);
delta_z = cell(Naz, 1);
x = cell(Naz, 1);
z= cell(Naz, 1);
L = cell(Naz, 1);
H = cell(Naz, 1);

for i = 1:Naz
	delta_x{i} = cos(deg2rad(Sloc{i})) * radius;
	delta_z{i} = sin(deg2rad(Sloc{i})) * radius;
	x{i} = delta_x{i} + centerx;
	z{i} = delta_z{i} + centerz;
	L{i} = radius - delta_x{i};
end
H = z;


fp = fopen('supportdata.txt', 'w');

for i = 1:Naz
	az = -100 + (i-1)*10;
	
	fprintf(fp, 'Azimuth %d\n', az);
	fprintf(fp, 'EL\tdelta_x\tdelta_z\tx (in)\tz (in)\tL (in)\tH (in)\n');
	for j = 1:length(Sloc{i})
		fprintf(fp, '%d\t%.1f\t%.1f\t%.1f\t%.1f\t%.1f\t%.1f\n', Sloc{i}(j), delta_x{i}(j), delta_z{i}(j), x{i}(j), z{i}(j), L{i}(j), H{i}(j));
	end
	fprintf(fp, '\n\n');
end
fclose(fp);


		