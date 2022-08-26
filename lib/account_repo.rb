require_relative './account.rb'

class AccountRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
        sql = 'SELECT id, username, email_address FROM accounts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        users = []

        result_set.each do |info|
          user = Account.new
          user.id = info['id']
          user.username = info['username']
          user.email_address = info['email_address']

          users << user
        end

      return users
      # Returns an array of username objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
        sql = 'SELECT * FROM accounts WHERE id = $1'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        accounts = []

        result_set.each do |info|
          user = Account.new
          user.username = info['username']
          user.email_address = info['email_address']

          accounts << user
        end
        return accounts

      # Returns a single username object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(username)
      
      
      sql = 'INSERT INTO accounts (username, email_address) VALUES ($1, $2)'
      params = [username.username, username.email_address]
      params2 = username.email_address

      result_set = DatabaseConnection.exec_params(sql, params)

      return nil
  
    end
  
    def delete(username)
      sql = 'DELETE FROM accounts WHERE username = $1'
      params = [username]
      DatabaseConnection.exec_params(sql, params)
      return nil
    end
  end