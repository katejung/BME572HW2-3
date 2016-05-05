function [u1,u2,w,e] = perceptron_2layers_2D( input_matrix,d,params )
% Compute the weight matrices from the input matrix

d = d./10;
% Hidden layer has a weight matrix of u
% The weight matrix is initialized to a value between 0 to 0.1
u1 = 0.1*rand(size(input_matrix,2),2);
u2 = 0.1*rand(size(input_matrix,2),2);

% Output layer has a weight matrix of w
% The output layer does not have a off-set perceptron
w = 0.1*rand(size(input_matrix,2),1);

% Compute the output of the perceptron and the error
j = 1;
converge = 0;
% Stop the perceptron iterations only if the solution is converged or the
% iteratio has been done more than 300 times of the input data or 5 million.
while converge == 0 && j < size(input_matrix,1)*300 && j < 5000000
    for i = 1:size(input_matrix,1)
        % Logistic function
        if params.logistics
            % Calculate output node
            v1 = input_matrix(i,:)*u1(:,end-1:end);
            y1 = [1 1./(1+ exp(-params.a*v1))];
            v2 = y1*u2(:,end-1:end);
            y2 = [1 1./(1+ exp(-params.a*v2))];
            ov = y2*w(:,end);
            o = 1/(1+ exp(-params.a*ov));
            % Back propagate
            e(j) = (d(i)-o);
            % delta_o is scaler because there is only one output node
            delta_o = params.a*e(j)*(o)*(1-o);
            % Note that the y has a offset note, which has no weight
            % connected to the input
            delta_h2 = params.a*y2(2:end).*(1-y2(2:end)).*(delta_o*w(2:end,end))';
            delta_h1 = params.a*y1(2:end).*(1-y1(2:end)).*(delta_h2*u2(2:end,end))';

            % Update the weights for each network
            if params.saveweights
                w = [w (w(:,end)+params.eta*delta_o.*y2')];
                u1 = [u1 (u1(:,end-1:end)+params.eta*input_matrix(i,:)'*delta_h1)];
                u2 = [u2 (u2(:,end-1:end)+params.eta*y1'*delta_h2)];
            else
                w = (w(:,end)+params.eta*delta_o.*y2');
                u1 = (u1(:,end-1:end)+params.eta*input_matrix(i,:)'*delta_h1);
                u2 = (u2(:,end-1:end)+params.eta*y1'*delta_h2);
            end
            % Hyperbolic tangent function
        elseif params.tangentf
            % Calculate output node
            v1 = input_matrix(i,:)*u1(:,end-1:end);
            y1 = [2 params.a*tanh(params.b*v1)];
            v2 = y1*u2(:,end-1:end);
            y2 = [2 params.a*tanh(params.b*v2)];
            ov = y4*w(:,end);
            o = params.a*tanh(params.b*ov);
            % Back propagate
            e(j) = (d(i)-o);
            % delta_o is scaler because there is only one output node
            delta_o = params.b/params.a*e(j)*(params.a-o)*(params.a+o);
            % Note that the y has a offset note, which has no weight
            % connected to the input
            delta_h2 = params.b/params.a*(params.a-y2(2:end)).*(params.a+y2(2:end))*(delta_o*w(2:end))';
            delta_h1 = params.b/params.a*(params.a-y1(2:end)).*(params.a+y1(2:end))*(delta_h2*u2(2:end))';

            if params.saveweight
                w = [w (w(:,end)+params.eta*delta_o.*y4')];
                u1 = [u1 (u1(:,end-1:end)+params.eta*input_matrix(i,:)'*delta_h1)];
                u2 = [u2 (u2(:,end-1:end)+params.eta*y1'*delta_h2)];
            else
                w = (w(:,end)+params.eta*delta_o.*y4');
                u1 = (u1(:,end-1:end)+params.eta*input_matrix(i,:)'*delta_h1);
                u2 = (u2(:,end-1:end)+params.eta*y1'*delta_h2);
            end
        end
        % Consider the solution to be converged if the error is smaller
        % than 1% error
        if e(j) < 0.01 && e(j) > -0.01
            converge = 1;
            break;
        end
        if mod(j,5000) == 0
            j
            e(end)
        end
        j = j + 1;
    end
end
