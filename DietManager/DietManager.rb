require './FoodDB'
require './Log'

class DietManager
  def initialize()
    @dbFile = "FoodDB.txt"
    @logFile = "DietLog.txt"
    @database = FoodDB.new(@dbFile)
    @log = Log.new(@logFile)
    @dbChanged = false
    @logChanged = false

  end
  
  #Handles the 'quit' command which exits the DietManager
  def command_quit
    if @dbChanged || @logChanged
      self.command_save
    end
    abort

  end

  #Handles the 'save' command which saves the FoodDB and Log if necessary
  def command_save
    if @dbChanged
      @database.save
      puts
      puts "Database saved"
      puts
    elsif @logChanged
      @log.save
      puts
      puts "Log saved"
      puts
    else
      puts
      puts "No changes were made to the Database or Log"
      puts
    end

  end

  #Handles the 'new food' command which adds a new BasicFood to the FoodDB
  def command_newFood(name, calories)
    puts
    if @database.contains_food?(name)
      puts "#{name} Food already in Database"
      puts
    else
      @database.add_basicFood(name, calories)
      puts "#{name} was added to the Database"
      @dbChanged = true
    end
    puts
  end

  #Handles the 'new recipe' command which adds a new Recipe to the FoodDB
  def command_newRecipe(name, ingredients)
    puts
    if @database.contains_recipe?(name)
      puts "#{name} Recipe already in Database"
    else
      ingredients.each do |ingredient|
        if !@database.contains_food?(ingredient)
          puts "#{ingredient} not found in Database"
          return nil
        end
      end
      @database.add_recipe(name, ingredients)
      puts "#{name} added to the Database"
      puts
      @dbChanged = true
    end

  end

  #Handles the 'print' command which prints a single item from the FoodDB
  def command_print(name)
    if @database.contains?(name)
      puts
      puts @database.get(name)
      puts
    else
      puts
      puts "Food does not exist in Database"
      puts

    end

  end

  #Handles the 'print all' command which prints all items in the FoodDB
  def command_printAll
    for i in @database.basicFoods
      puts i.to_s
    end
    puts $INPUT_RECORD_SEPARATOR
    for r in @database.recipes
      puts r.to_s
    end
    puts $INPUT_RECORD_SEPARATOR
  end

  #Handles the 'find' command which prints information on all items in the FoodDB matching a certain prefix
  def command_find(prefix)
    puts
    matches = @database.find_matches(prefix)
    if matches.size == 0
      puts "No food with this prefix"
      puts
      nil
    end
    matches.each do |food|
      puts food
      puts
    end
  end

  #Handles both forms of the 'log' command which adds a unit of the named item to the log for a certain date
  def command_log(name, date = Date.today)
    puts
    if !@database.contains?(name)
      puts "#{name} not in Database"
      puts
      return nil
    end
    @log.add_logItem(name, date)
    if date != Date.today
      puts "#{name} added to log for #{date}"
    else

      val = (Date.today).to_s
      vals = val.split("-")
      month = vals[1]
      day = vals[2]
      year = vals[0]
      new_date = "%s/%s/%s" % [month,day,year]
      puts "#{name} added to log for today, #{new_date}"
    end
    puts
    @logChanged = true

  end

  #Handles the 'delete' command which removes one unit of the named item from the log for a certain date
  def command_delete(name, date)
    _date = date.split('/')
    date_ = Date.parse("#{_date[2]}-#{_date[0]}-#{_date[1]}")

    @log.remove_logItem(name, date_)
    # command_save
    @logChanged = true
  end

  #Handles both forms of the 'show' command which displays the log of items for a certain date
  def command_show(date = Date.today)
    _date = date.split('/')
    date_ = Date.parse("#{_date[2]}-#{_date[0]}-#{_date[1]}")
    if @log.get_entries(date_) == nil
    	puts "There are no entries for this date"
    else
    @log.get_entries(date_).each do |i|
      puts i.name
    end
    puts $INPUT_RECORD_SEPARATOR
    end
  end
  #Handles the 'show all' command which displays the entire log of items
  def command_showAll
    puts
    stuff = []
    entries = @log.get_entries
    entries.each do |entry|
      items = entry
      stuff.push(items)
    end
    count = 0
    stuff.each do |i|
      if i[count]== nil || i[count]== nil
        break
      else
      puts(i[count].date)
      puts("  ".concat(i[count].name).to_s)
        end
    end
    puts
  end



end #end DietManager class


  def formatInput(input)
    input.gsub(/\w+/) { |word| word.capitalize }
  end


#MAIN

dietManager = DietManager.new

puts "Input a command > "

#Read commands from the user through the command prompt
$stdin.each  do |line|
  line = line.gsub("\n","")
  split = line.split(' ')
  comma = line.split(',')
  puts $INPUT_RECORD_SEPARATOR
  case split[0]
  when 'log'
    x = split[1].split(',')
    na = comma[0].split(' ')
    nam = na[1..2].join(' ')
    dat = comma[1]
    if x.size > 1
      dietManager.command_log(nam, dat)
    else
      dietManager.command_log(nam, Date.today)
    end
  when 'delete'
    inc_date = comma[1]
    na  = comma[0].split(' ')
    nam = na[1]
    dietManager.command_delete(nam, inc_date)
  when 'show'
    if split[1] == 'all'
      dietManager.command_showAll
    else
      datee = split[1]
      dietManager.command_show(datee)
    end
  when 'quit'
    dietManager.command_quit
  when 'new'
    x = split[2].split(',')
    if split[1] == 'food'
      na = comma[0].split(' ')
      nam = na[2..3].join(' ')
      cal = comma[1]
      dietManager.command_newFood(nam, cal)
    else
      na = comma[0].split(' ')
      nam = na[2..3].join(' ')
      ing = comma[1..-1]
      dietManager.command_newRecipe(nam, ing)
    end
  when 'print'
    if split[1] == 'all'
      dietManager.command_printAll
    else
      printer = split[1..-1].join(" ")

      dietManager.command_print(printer)
    end
  when 'find'
    dietManager.command_find(formatInput(split[1]))
  end
end
