class_num = 16;
speakers = 10;
M = {};
Cov = {};
Weight = {};

% train model
for model_num=1:speakers
	features_train = [];
	for train_cnt=1:2
		filename=strcat(strcat(strcat(strcat('MFCC\', num2str(model_num)), '_'), num2str(train_cnt) ),'.mfc');
		[features,samPeriod,paramKind] = readhtk_lite(filename);
		features_train = [features_train;features];
	end
	[M{model_num},Cov{model_num},Weight{model_num}]=gaussmix(features_train,[],[],class_num,'v');
end

% TEST
accuracy = [];
for test_sample=3:10
	correct_count = 0;
	for person=1:speakers
		max = -10e10;
		train_file = strcat(strcat(strcat(strcat('MFCC\', num2str(person)), '_'), num2str(test_sample) ),'.mfc');
		[features,samPeriod,paramKind] = readhtk_lite(train_file);
		% Test speaker using all model
		for model_cnt = 1:speakers
			accu = 0;
			for i = 1:size(features,1)
			    accu = accu + log(gaussianND(features(i,:),M{model_cnt},Cov{model_cnt},class_num));
			end
			if accu > max
				max = accu;
				index = model_cnt;
			end
		end
		% Check if speaker is correctly recognized
		if index == person
			correct_count = correct_count + 1;
		end
		% display(index)
	end
	accuracy(test_sample - 2) = correct_count * 100 / speakers;
	accuracy_str = ['Test sample ', num2str(test_sample) ,' Accuracy: ' , num2str(correct_count * 100 / speakers) , '%'];
	display(accuracy_str);
end

bar(accuracy);
title 'Accuracy vs Test Sample'
xlabel 'Test Sample', ylabel 'Accuracy';