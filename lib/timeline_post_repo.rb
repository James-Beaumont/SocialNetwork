require_relative './timeline_post.rb'

class TimelinePostRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, title, content, views, username_id FROM timeline_posts'
      result_set = DatabaseConnection.exec_params(sql, [])

      timelines = []

      result_set.each do |info|
        timeline = TimelinePost.new
        timeline.id = info['id']
        timeline.title = info['title']
        timeline.content = info['content']
        timeline.views = info['views']
        timeline.username_id = info['username_id']

        timelines << timeline
      end

    return timelines
      # Returns an array of username objects.
    end
  
    def find(id)
      # Executes the SQL query:
      sql = 'SELECT id, title, content, views, username_id FROM timeline_posts WHERE id = $1'
      params = [id]
      result_set = DatabaseConnection.exec_params(sql, params)
      timelines = []

      result_set.each do |info|
        timeline = TimelinePost.new
        timeline.id = info['id']
        timeline.title = info['title']
        timeline.content = info['content']
        timeline.views = info['views']
        timeline.username_id = info['username_id']

        timelines << timeline
      end
      return timelines
      # Returns a single username object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(timeline_post)
      
      
      sql = 'INSERT INTO timeline_posts (title, content, username_id) VALUES ($1, $2, $3)'
      params = [timeline_post.title, timeline_post.content, timeline_post.username_id]
      result_set = DatabaseConnection.exec_params(sql, params)

      return nil
  
    end
  
    def delete(id)
      sql = 'DELETE FROM timeline_posts WHERE title = $1'
      params = [id]
      DatabaseConnection.exec_params(sql, params)
      return nil
    end
  end