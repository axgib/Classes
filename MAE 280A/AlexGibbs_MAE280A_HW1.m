%%Exercise 7

A = [ 1 1 1 0; 1 2 2 1; 2 5 5 3];

A = rref(A) %part A: range space spans {[1 0 0], [ 0 1 0]}

RAt = A.';%part B



%% Exercise 9
% clear; clc;

L = [1 2; 7 8; 21 -1];

P = L * L.';

Z = [ 1 -2 3 -2; -1 -1 -1 -1; 4 4 5 4; 7 8 9 2];

X = Z * Z.';

%% P1

eig(P) % >= 0 thus positive semi definite
eig(X) % > 0 thus positive definite
%% P2

% Written in PDF - A * AT will always produce an nxn matrix 
% and the eigenvalues will always be real because the eigenvectors are
% linearly dependent. We can prove this by taking the determinant
%% P3

rankP = rank(P)
rankX = rank(X)

eigP = eig(P)
eigX = eig(X)

svdP = svd(P)
svdX = svd(X)
%% P4

A = [1 2 3; 2 4 5; 3 5 6];

eigA = eig(A)

T = solve(T*A*T.' == diag(eigA), T)
