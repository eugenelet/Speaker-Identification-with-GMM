features = [];
samPeriod = [];
paramKind = [];

[features{1},samPeriod{1},paramKind{1}] = readhtk_lite('FCEG0_1.mfc');
[features{2},samPeriod{2},paramKind{2}] = readhtk_lite('MBCG0_1.mfc');

% features = [features_1, features_2];

for i=1:2
	% Smoothed Histogram
	figure((i-1)*5 + 1);
	n = hist3(MFCC_2D, [9 9],'FaceAlpha',.85);
	%density with gridfit function  
	nb_interp_point = 100;
	[x,y] = meshgrid(1:size(n,1),1:size(n,2));  
	zgrid = gridfit(x(:), y(:), n, nb_interp_point, nb_interp_point);  
	surf(zgrid,'EdgeColor','none')  
	set(gca,'YDir','reverse','XDir','reverse');  
	xlabel('MFCC1'); ylabel('MFCC2');
	title(strcat(num2str(i),strcat('Histogram Plot (Interpolated) ',num2str(i))))
	for j=1:4
		% MFCC_1 = features{i}(:,1:2);
		% MFCC_2 = features{i}(:,1:2);

		MFCC_2D = features{i}(:,1:2);%[MFCC_1, MFCC_2];

	% Histogram
		% figure(1 + (i-1)*3);
		% hist3(MFCC_2D, [9 9],'FaceAlpha',.85);
		% title(strcat('Histogram Plot (Discrete)  ' , num2str(i)))
		% set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
		% xlabel('MFCC1'); ylabel('MFCC2');



	% GMM plot
		feature_2d = features{i}(:,1:2);
		[M,var,Weight]=gaussmix(feature_2d,[],[],4 * 2^j);

		figure((i-1)*5 + 1 + j);
		my_gaussianplot(feature_2d,M,var,Weight);
		title(strcat(num2str(i),strcat('GMM Plot ',num2str(4 * 2^j))))
	end
end









