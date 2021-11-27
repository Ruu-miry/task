require "sqlite3"
class Student 

    def initialize(command)
        @command = command
        @db = SQLite3::Database.open 'school.db'
        @db.execute "CREATE TABLE IF NOT EXISTS  students(id INT, name TEXT)"
    end

    def create
        p "id入力"
        id = gets.to_i
        p "name入力"
        name = gets.chomp
        @db.execute "INSERT INTO students(id,name) values(?,?)", id,name
    end


    def select
        select = @db.execute "SELECT * FROM students"
        if select == []
            p "table empty"
        else
            select.each do |row|
                p "[#{row[0]}]#{row[1]}"
            end
         end
    end 

    def delete
        p "id削除"
        id = gets.chomp
        @db.execute "DELETE FROM students WHERE id=?" ,id
    end
end

def getCommands
    command = ""
    while command != "e"    
        command = gets.chomp
        student = Student.new(command)

        if(command == "i")
            student.create
        elsif(command == "s")
            student.select
        elsif(command == "d")
            student.delete
        end
    end
end

getCommands 