clc;

% motivation
% features are redundant / irrelevant, that's why
% we try to find the best features and neglect the others
% if I managed to reduce features and get better rmse on fourk dataset
% I'm quite sure this will help in imporving the prediction when
% using the actual test set and submit the results on kaggle

% first algorithm
clc;

% include directories
addpath(genpath('./Data/'));
addpath(genpath('./Shared/'));

% load the data
load('Data\t_train.mat');
load('Data\t_test.mat');
load('Data\t_truth.mat');

% the matrix is M x N
% m is the users, n is the jokes
M   = 500;
N   = 10;

% just train your model on a small portion
t_test = t_test(1:M,:);
t_test = t_test(:,1:N);

% truth
t_truth = t_truth(1:M,:);
t_truth = t_truth(:,1:N);

% shift the 99
t_test(t_test == 99) = 0;

% perform SVD and get the esitmated user ratings
[U,S,V] = svd(t_test);
t_estm = U*S*V';

% random walk, if I just placed zero
% (i.e the average number), what would happen
t_rand = t_test;
t_rand(t_rand == 99) = 0;

% get the errors
[confusionEstm, rmseEstm, ameEstm] = calcError(t_truth, t_test, t_estm, 99);
[confusionRand, rmseRand, ameRand] = calcError(t_truth, t_test, t_rand, 99);

% plot results
plotResult(confusionEstm, rmseEstm, ameEstm, confusionRand, rmseRand, ameRand);



