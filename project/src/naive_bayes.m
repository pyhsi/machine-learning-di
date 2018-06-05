% Naive Bayes Implementation

function naive_bayes(Train_array, Train_array_pos, Train_array_response, Operational_array, Operational_array_pos, Operational_array_response)
    
    N = length(Train_array_pos);
    Train_array_category_1 = [];
    Train_array_category_1_pos = [];
    Train_array_category_2 = [];
    Train_array_category_2_pos = [];
    Train_array_category_3 = [];
    Train_array_category_3_pos = [];
    Train_array_category_4 = [];
    Train_array_category_4_pos = [];
    Train_array_category_5 = [];
    Train_array_category_5_pos = [];

    for i = 1:N
        if (Train_array_response(i) == 1)
            Train_array_category_1 = [Train_array_category_1 Train_array(:,i)];
            Train_array_category_1_pos = [Train_array_category_1_pos; Train_array_pos(i, 1), Train_array_pos(i, 2)];
        elseif (Train_array_response(i) == 2)
            Train_array_category_2 = [Train_array_category_2 Train_array(:,i)];
            Train_array_category_2_pos = [Train_array_category_2_pos; Train_array_pos(i, 1), Train_array_pos(i, 2)];
        elseif (Train_array_response(i) == 3)
            Train_array_category_3 = [Train_array_category_3 Train_array(:,i)];
            Train_array_category_3_pos = [Train_array_category_3_pos; Train_array_pos(i, 1), Train_array_pos(i, 2)];
        elseif (Train_array_response(i) == 4)
            Train_array_category_4 = [Train_array_category_4 Train_array(:,i)];
            Train_array_category_4_pos = [Train_array_category_4_pos; Train_array_pos(i, 1), Train_array_pos(i, 2)];
        elseif (Train_array_response(i) == 5)
            Train_array_category_5 = [Train_array_category_5 Train_array(:,i)];
            Train_array_category_5_pos = [Train_array_category_5_pos; Train_array_pos(i, 1), Train_array_pos(i, 2)];
        end
    end

    Train_array_category_1 = Train_array_category_1';
    Train_array_category_2 = Train_array_category_2';
    Train_array_category_3 = Train_array_category_3';
    Train_array_category_4 = Train_array_category_4';
    Train_array_category_5 = Train_array_category_5';

    % figure(7), plotmatrix(Train_array_category_1, '*r');
    % figure(8), plotmatrix(Train_array_category_2, '.b');
    % figure(9), plotmatrix(Train_array_category_3, 'Og');
    % figure(10), plotmatrix(Train_array_category_4, '+b');
    % figure(11), plotmatrix(Train_array_category_5, '-r');

    % Number of elements per category
    N1 = length(Train_array_category_1);
    N2 = length(Train_array_category_2);
    N3 = length(Train_array_category_3);
    N4 = length(Train_array_category_4);
    N5 = length(Train_array_category_5);

    % Sigma of the categories
    s1 = std(Train_array_category_1);
    s2 = std(Train_array_category_2);
    s3 = std(Train_array_category_3);
    s4 = std(Train_array_category_4);
    s5 = std(Train_array_category_5);

    % Maximum likelihood estimates of the means
    m1_ML = mean(Train_array_category_1);
    m2_ML = mean(Train_array_category_2);
    m3_ML = mean(Train_array_category_3);
    m4_ML = mean(Train_array_category_4);
    m5_ML = mean(Train_array_category_5);

    % Estimation of the a priori probabilities
    P1 = N1/(N);
    P2 = N2/(N);
    P3 = N3/(N);
    P4 = N4/(N);
    P5 = N5/(N);

    % Vector containing the class labels of
    output = [];

    N_Operation = length(Operational_array_pos);
    disp(N_Operation);
    for i = 1:N_Operation
        point = Operational_array(:, i)';

        p1 = normcdf(point, m1_ML, s1);
        p2 = normcdf(point, m2_ML, s2);
        p3 = normcdf(point, m3_ML, s3);
        p4 = normcdf(point, m4_ML, s4);
        p5 = normcdf(point, m5_ML, s5);

        p1_prod = prod(p1);
        p2_prod = prod(p2);
        p3_prod = prod(p3);
        p4_prod = prod(p4);
        p5_prod = prod(p5);

        % Application of the Bayes rule
        bayes_rule_1 = P1*p1_prod;
        bayes_rule_2 = P2*p2_prod; 
        bayes_rule_3 = P3*p3_prod;
        bayes_rule_4 = P4*p4_prod;
        bayes_rule_5 = P5*p5_prod;

        bayes_rule = [bayes_rule_1 bayes_rule_2 bayes_rule_3 bayes_rule_4 bayes_rule_5];

        max_probability = max(bayes_rule);

        if (max_probability == bayes_rule_1)
            output = [output 1];
        elseif (max_probability == bayes_rule_2)
            output = [output 2];
        elseif (max_probability == bayes_rule_3)
            output = [output 3];
        elseif (max_probability == bayes_rule_4)
            output = [output 4];
        elseif (max_probability == bayes_rule_5)
            output = [output 5];
        end
    end

    errors = 0;
    for i = 1:N_Operation
        if(output(i) ~= Operational_array_response(i))
            errors = errors + 1;
        end
    end
    correct = N_Operation - errors;
    accuracy = (correct/N_Operation) * 100;
    fprintf('Accuracy: %.2f%%\n', accuracy);
end