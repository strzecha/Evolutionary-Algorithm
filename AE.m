function [X, value, totalCrossed, totalMutated] = AE(items, N, nPop, pCross, pMut, it)
    rng(0);
    bestValue = 0;
    bestValues = zeros(it, 1);
    avgs = zeros(it, 1);
    worseValues = zeros(it, 1);
    vars = zeros(it, 1);
    bestX = zeros(N, 1);
    iter = (1:it);
    totalCrossed = 0;
    totalMutated = 0;
    W = sum(items(:, 1)) * 0.3;
    P = round(rand(nPop, N));
    
    tic;
    for i=1:it
        [X, value, avg, varc, worseX] = evaluate(P, items, W, N, nPop);
        if value >= bestValue
            bestValue = value;
            bestX = X;
        end
        bestValues(i) = value;
        worseValues(i) = worseX;
        avgs(i) = avg;
        vars(i) = varc;
        P = reproduction(P, nPop, items, W);
        [P, mutated] = mutation(P, nPop, pMut, N);
        [P, crossed] = crossover(P, nPop, pCross, N);
        totalMutated = totalMutated + mutated;
        totalCrossed = totalCrossed + crossed;
        P(nPop, :) = bestX;
    end
    toc;
    X = bestX;
    value = bestValue;

    nexttile;
    hold on;
    plot(iter, bestValues, 'g', 'DisplayName', 'Best value');
    plot(iter, worseValues, 'r', 'DisplayName', 'Worse value');
    plot(iter, avgs, 'm', 'DisplayName', 'Avegare value');
    xlabel("ganeration");
    ylabel("value");
    legend("show");
    hold off;
    
    nexttile;
    plot(iter, vars, 'c', 'DisplayName', 'Variancy'); 
    xlabel("generation");
    ylabel("value");
    legend("show");
    
    

end  

function [bestX, bestValue, avg, varc, worseX] = evaluate(P, items, W, N, nPop)
    bestValue = 0;
    bestX = zeros(N, 1);
    values = zeros(nPop, 1);
    for j=1:nPop
        X = P(j, :);
        value = grade(X, items, W);
        values(j) = value;
        if value >= bestValue
            bestValue = value;
            bestX = X;
        end

    end
    avg = mean(values);
    varc = var(values);
    worseX = min(values);
end

function [P] = reproduction(P, nPop, items, W)
    newP = P;
    for i=1:nPop
        index1 = randi([1, nPop], 1, 1);
        index2 = randi([1, nPop], 1, 1);

        if grade(P(index1, :), items, W) > grade(P(index2, :), items, W)
            newP(i, :) = P(index1, :);
        else
            newP(i, :) = P(index2, :);
        end
    end
    P = newP;
end

function [P, num_mutated] = mutation(P, nPop, pMut, N)
    num_mutated = 0;
    for i=1:nPop
        mut = false;
        for j=1:N
            chance = rand(1);
            if chance < pMut
                P(i, j) = abs(P(i, j) - 1);
                mut = true;
            end
        end
        if mut
            num_mutated = num_mutated + 1;
        end
    end
end

function [P, num_crossed] = crossover(P, nPop, pCross, N)
    num_crossed = 0;
    for i=1:nPop
        chance = rand(1);
        if chance < pCross
            num_crossed = num_crossed + 1;
            for j=1:N
                chance2 = rand(1);
                if chance2 >= 0.5
                    P(i, j) = P(i, j);
                else
                    if i == nPop
                        P(i, j) = P(1, j);
                    else
                        P(i, j) = P(i+1, j);
                    end
                end
            end
        end
    end
end

function [value] = grade(X, items, W)
    totalWeight = sum(X' .* items(:, 1));
    value = sum(X' .* items(:, 2)) * (totalWeight <= W);
end

