function X = LS_fit(Y, H)
    [m, n] = size(H);
    X = zeros(n,1);
    P = eye(n).*1000;
    
    for k = 0:1:m-1
        P = P - P*H(k+1,:)'*((1+H(k+1,:)*P*H(k+1,:)') \ H(k+1,:))*P;
        K = P*H(k+1,:)';
        X = X + K*(Y(k+1)-H(k+1,:)*X);
    end
end