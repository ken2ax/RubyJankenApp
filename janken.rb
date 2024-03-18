def score(player_win, player_lose)
  player_win = player_win.to_s
  player_lose = player_lose.to_s
  puts "-------------"
  puts "現在" + player_win + "勝" + player_lose + "敗です"
  puts "-------------"
end

def hand_trans(janken_you, janken_enemy)
  case janken_you
  when 1
    puts "あなた:グー"
  when 2
    puts "あなた:チョキ"
  when 3
    puts "あなた:パー"
  end
  
  case janken_enemy
  when 1
    puts "相手:グー"
  when 2
    puts "相手:チョキ"
  when 3
    puts "相手:パー"
  end
end

def illegal_input(player_choice)
  until [1, 2, 3, 4].include?(player_choice)
    puts "-------------"
    puts "不正な値です。1、2、3、4のいずれかを入力してください"
    player_choice = gets.chomp.to_i
  end
  return player_choice
end

def look_that_way_trans(player_choice, enemy_choice)
  case player_choice
  when 1
    puts "あなた:左"
  when 2
    puts "あなた:下"
  when 3
    puts "あなた:上"
  when 4
    puts "あなた:右"
  end

  case enemy_choice
  when 1
    puts "相手:左"
  when 2
    puts "相手:下"
  when 3
    puts "相手:上"
  when 4
    puts "相手:右"
  end
end


def finger_turn(player_win, game_judge)
  puts "-------------"
  puts "あっち向いて..."
  puts "指を指す方向を選んでください"
  puts "1(左)2(下)3(上)4(右)"
  
  player_choice = gets.chomp.to_i
  enemy_choice = rand(1..4)

  player_choice = illegal_input(player_choice)

  puts "-------------"
  puts "ほい！"
  puts "-------------"
  look_that_way_trans(player_choice, enemy_choice)

  #選択が同じ場合
  if player_choice == enemy_choice
    player_win += 1
    game_judge += 1
  end
  return player_win, game_judge
end

def look_turn(player_lose, game_judge)
  puts "-------------"
  puts "あっち向いて..."
  puts "首を向ける方向を選んでください"
  puts "1(左)2(下)3(上)4(右)"

  player_choice = gets.chomp.to_i
  enemy_choice = rand(1..3)

  player_choice = illegal_input(player_choice)

  puts "-------------"
  puts "ほい！"
  look_that_way_trans(player_choice, enemy_choice)

  if player_choice == enemy_choice
    player_lose += 1
    game_judge += 1
  end
  return player_lose, game_judge
end

def result(player_win, player_lose)
  player_win = player_win.to_s
  player_lose = player_lose.to_s
  puts "-------------"
  puts "今回は" + player_win + "勝" + player_lose + "敗で"
end

def endgame(player_win, player_lose)
  player_win = player_win.to_s
  player_lose = player_lose.to_s
  puts "-------------"
  puts "終了します"
  puts "今回の戦績は" + player_win + "勝" + player_lose + "敗でした"
  puts "-------------"
  exit
end

player_win = 0
player_lose = 0
game_judge = 0

#ここからスタート
#検証しやすいようにとりあえず3本勝負で設定してみる
until game_judge == 3
  score(player_win, player_lose)

  puts "じゃんけん..."
  puts "1(グー)2(チョキ)3(パー)0(終了)"

  janken_you = gets.chomp.to_i
  janken_enemy = rand(1..3)

  #1、2、3、0以外が入力された場合
  until [1, 2, 3, 0].include?(janken_you)
    puts "-------------"
    puts "不正な値です。1、2、3、0のいずれかを入力してください"
    janken_you = gets.chomp.to_i
  end

  #0が入力されたら終了する
  if janken_you == 0
    endgame(player_win, player_lose)
  end

  puts "-------------"
  puts "ぽん！"
  puts "-------------"
  hand_trans(janken_you, janken_enemy)

  #あいこだった場合
  while janken_you == janken_enemy
    puts "-------------"
    puts "あいこで..."
    puts "1(グー)2(チョキ)3(パー)0(終了)"
    janken_you = gets.chomp.to_i

    until [1, 2, 3, 0].include?(janken_you)
      puts "-------------"
      puts "不正な値です。1、2、3、0のいずれかを入力してください"
      janken_you = gets.chomp.to_i
    end
    
    if janken_you == 0
      endgame(player_win, player_lose)
    end 

    janken_enemy = rand(1..3)
    puts "-------------"
    puts "しょ！"
    hand_trans(janken_you, janken_enemy)
  end

  if janken_you == 1
    case janken_enemy
    when 2 
      player_win, game_judge = finger_turn(player_win, game_judge)
    when 3
      player_lose, game_judge = look_turn(player_lose,game_judge)
    end
  end

  if janken_you == 2
    case janken_enemy 
    when 3 
      player_win, game_judge = finger_turn(player_win, game_judge)
    when 1
      player_lose, game_judge = look_turn(player_lose,game_judge)
    end
  end

  if janken_you == 3
    case janken_enemy
    when 1 
      player_win, game_judge = finger_turn(player_win, game_judge)
    when 2
      player_lose, game_judge = look_turn(player_lose,game_judge)
    end
  end

  if game_judge == 3
    if player_win > player_lose
      result(player_win, player_lose)
      puts "あなたの勝ちです"
      puts "-------------"
    else
      result(player_win, player_lose)
      puts "あなたの負けです"
      puts "-------------"
    end
  end
end