class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id
  # class needs 2 attr name and grade
  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  # method to create student table in db
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      );
      SQL
      DB[:conn].execute(sql)
  end
  #method that can drop the table
  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  # method to save data of individual student obj to db
  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  # create method that saves AND creates new instance to db
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
