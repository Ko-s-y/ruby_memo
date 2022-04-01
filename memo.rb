require "csv"

def memo_editor()
  puts "1(新規でメモを作成する) 2(既存のメモに追加する) 3(既存のメモを参照する)"
  memo_type = gets.to_i
  current_filelist = []
  Dir.foreach('.') do |item|  #同階層のファイル取得cuurent_filelestへ
    next if item == '.' or item == '..'
    current_filelist.push(item)
  end

#新規作成
  if memo_type == 1
    puts "拡張子を除いたファイル名を入力してください"
    file = gets.to_s.chomp
    file_name = file.concat(".csv")
    if current_filelist.include?(file_name)  #意図しない上書き防止
      puts "同じ名前のファイルが既に存在しています" 
      puts "1(もう一度実行する) その他のキー(終了する)"
      pick_type = gets.to_i
      if pick_type == 1
        memo_editor()
      else
        puts "終了しました"
      end
    else
      CSV.open(file_name,'w') do |memo|
        puts "メモしたいものを入力してください"
        text = gets.to_s.chomp
        memo << [text]
        puts "新規メモの作成が完了しました"
      end
    end

#既存メモに追加
  elsif memo_type == 2
    puts "拡張子を除いた既存ファイル名を入力してください"
    file = gets.to_s.chomp
    file_name = file.concat(".csv")
    if current_filelist.include?(file_name)
      CSV.open(file_name,'a') do |memo|
        puts "追加したい事を入力してください"
        text = gets.to_s.chomp
        memo << [text]
        puts "既存メモに追加しました"
      end
    else
      puts "指定したファイルは存在しません"
      puts "1(もう一度実行する) その他のキー(終了する)"
      pick_type = gets.to_i
      if pick_type == 1
        memo_editor()
      else
        puts "終了しました"
      end
    end

#既存メモを参照
  elsif memo_type == 3
    puts "拡張子を除いた既存ファイル名を入力してください"
    file = gets.to_s.chomp
    file_name = file.concat(".csv")
    begin
      memo_text = CSV.read(file_name)
      puts memo_text
    rescue
      puts "指定したファイルは存在しません"
      puts "1(もう一度実行する) その他のキー(終了する)"
      pick_type = gets.to_i
      if pick_type == 1
        memo_editor()
      else
        puts "終了しました"
      end
    end

#1,2,3以外が入力された時
  else
    puts "指定した数字を入力してください"
    puts "1(もう一度実行する) その他のキー(終了する)"
    pick_type = gets.to_i
    if pick_type == 1
      memo_editor()
    else
      puts "終了しました"
    end
  end
end

memo_editor()