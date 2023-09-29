using LibPQ, Tables


# Intialising Connection
conn = LibPQ.Connection(
    "host=localhost port=5432 dbname=your-postgres-database user=postgres password=your-postgres-password"
)

# Listing all tables in database:
result = LibPQ.execute(conn, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'")
data = rowtable(result)
@show data


# Creating tables

# Create a table called "students"
create_table_sql = """
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
)
"""

# Execute the SQL command to create the table
LibPQ.execute(conn, create_table_sql)

# Inserting into a Table
# Insert data into the "students" table
insert_sql = """
INSERT INTO students (first_name, last_name, age)
VALUES ('John', 'Doe', 25),
       ('Jane', 'Smith', 22)
"""

# Execute the SQL command to insert data
LibPQ.execute(conn, insert_sql)

# Selecting Details from Tables
# Select data from the "students" table
select_sql = "SELECT * FROM students"

# Execute the SQL command to select data
result = LibPQ.execute(conn, select_sql)

# Converting results to row tables
data = rowtable(result)

# Fetch and print results
for d in data
    println("ID: $(d[:id]), Name: $(d[:first_name]) $(d[:last_name]), Age: $(d[:age])")
end

# Deleting a Row from a Table

# Delete a specific row from the "students" table
delete_sql = "DELETE FROM students WHERE id = 1"

# Execute the SQL command to delete the row
LibPQ.execute(conn, delete_sql)

# Dropping a Table

# Drop the "students" table
drop_table_sql = "DROP TABLE students"

# Execute the SQL command to drop the table
LibPQ.execute(conn, drop_table_sql)

# Closing connection
close(conn)