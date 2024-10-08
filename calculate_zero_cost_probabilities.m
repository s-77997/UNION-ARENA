function probabilities = calculate_zero_cost_probabilities(totalCards, zeroCostCards)
    % totalCards: 合計のカード枚数（50枚）
    % zeroCostCards: 0コストのカードの枚数
    % probabilities: 各引きで0コストカードを引く枚数ごとの確率（最初の7枚および次の7枚）

    firstDraw = 7;   % 最初に引くカードの枚数
    secondDraw = 7;  % その後引くカードの枚数
    
    % 最初の引きで0コストのカードを引く確率
    first_prob = get_draw_probabilities(totalCards, zeroCostCards, firstDraw);
    
    % 残りの43枚に対して再度7枚引く
    remainingCards = totalCards - firstDraw;  % 残りのカード
    remainingZeroCostCards = zeroCostCards - (0:firstDraw);  % 各引きに対応する0コストカードの残り枚数
    
    % 2回目の引きで0コストカードを引く確率
    second_prob = zeros(length(first_prob), secondDraw+1);
    
    % 最初の引きで0〜7枚の0コストカードを引いた場合に、それに対応する残りからの引き確率を計算
    for k = 0:firstDraw
        second_prob(k+1, :) = get_draw_probabilities(remainingCards, remainingZeroCostCards(k+1), secondDraw);
    end
    
    % 結果として最初の引きと2回目の引きの確率を返す
    probabilities.firstDraw = first_prob;
    probabilities.secondDraw = second_prob;
    
    % 結果を表示
    disp('First draw probabilities:');
    disp(first_prob);
    
 % X軸は0コストカードを引く枚数（0～7枚）
    x = 0:firstDraw;
    
    % 棒グラフで表示
    figure;
    bar(x, first_prob, 'FaceColor', [0.2, 0.6, 0.8]);
    
    % グラフのラベルとタイトル
    xlabel('Number of 0-cost cards drawn');
    ylabel('Probability');
    title('Probability of drawing 0-cost cards (First Draw)');
    
    % X軸に整数値のラベルを設定
    xticks(0:firstDraw);
    
    % グリッドを表示
    grid on;


    disp('Second draw probabilities (for each case in the first draw):');
    disp(second_prob);
end

function prob = get_draw_probabilities(totalCards, zeroCostCards, drawCards)
    % 指定された引きでの確率を計算する関数
    % totalCards: 全カード枚数
    % zeroCostCards: 0コストのカード枚数
    % drawCards: 引くカードの枚数
    prob = zeros(1, drawCards+1);
    
    for k = 0:drawCards
        prob(k+1) = hygepdf(k, totalCards, zeroCostCards, drawCards);
    end
end
