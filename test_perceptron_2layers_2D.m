function class = test_perceptron_2layers_2D(w_in,test_image,params)
% test_perceptron_5layers_2D gives back the estimated digits for a test
% images.

u1 = w_in{1}; u2 = w_in{2}; w = w_in{3};
if params.logistics
    % Calculate output node
    v1 = test_image*u1(:,end-1:end);
    y1 = [1*ones(size(v1,1),1) 1./(1+ exp(-params.a*v1))];
    v2 = y1*u2(:,end-1:end);
    y2 = [1*ones(size(v2,1),1) 1./(1+ exp(-params.a*v2))];
    ov = y2*w(:,end);
    o = 1./(1+ exp(-params.a*ov));
    class = mean(o);
elseif params.tangentf
    % Calculate output node
    v1 = test_image*u1(:,end-1:end);
    y1 = [1 params.a*tanh(params.b*v1)];
    v2 = y1*u2(:,end-1:end);
    y2 = [1 params.a*tanh(params.b*v2)];
    ov = y2*w(:,end);
    o = params.a*tanh(params.b*ov);
    class = mean(o);
end




end

