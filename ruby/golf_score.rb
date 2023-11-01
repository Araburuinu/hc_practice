# frozen_string_literal: true

get_line = []
par_scores = []
player_scores = []
judge_scores = []
SCORE_MAPPING = { -3 => 'アルバトロス', -2 => 'イーグル', -1 => 'バーディ', 0 => 'パー', 1 => 'ボギー' }.freeze

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
    diff >= 2 ? judge_scores << "#{diff}ボギー" : judge_scores << SCORE_MAPPING[diff]
  end
end

puts judge_scores.join(',')
