# encoding: utf-8
#
# Популярная детская игра, Виселица

# Эта проверка нужна для корректного отображения кирилицы в windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем классы
require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

# Записываем версию игры в константу VERSION
VERSION = 'Игра виселица. Версия 5.0'

# Создаем экземпляр класса WordReader
word_reader = WordReader.new
words_file_name = "#{File.dirname(__FILE__)}/data/words.txt"
word = word_reader.read_from_file(words_file_name)

# Создаем игру и прописываем ее версию с помощью сеттера version=
game = Game.new(word)
game.version = VERSION

# Экземпляр ResultPrinter-а нельзя создать без игры
printer = ResultPrinter.new(game)

# Основной игровой цикл
while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
