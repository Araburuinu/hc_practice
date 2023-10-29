# frozen_string_literal: true

get_line = []
par_scores = []
player_scores = []
judge_scores = []

ARGF.each do |line|
  get_line << line
end

get_line[0].split(',').each do |i|
  par_scores << i.to_i
end

get_line[1].split(',').each do |i|
  player_scores << i.to_i
end

18.times.each do |i|
  if player_scores[i] == 1
    par_scores[i] == 5 ? judge_scores << 'コンドル' : judge_scores << 'ホールインワン'
  else
    diff = player_scores[i].to_i - par_scores[i].to_i
    judge_scores << '3ボギー' if diff == 3
    judge_scores << '2ボギー' if diff == 2
    judge_scores << 'ボギー' if diff == 1
    judge_scores << 'パー' if diff.zero?
    judge_scores << 'バーディ' if diff == -1
    judge_scores << 'イーグル' if diff == -2
    judge_scores << 'アルバトロス' if diff == -3
  end
end

puts judge_scores.join(',')
