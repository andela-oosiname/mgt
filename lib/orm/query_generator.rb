module Mgt
  class ActiveRecord
    def self.find_by(finder)
      key = finder.keys[0].to_s
      value = finder.values[0].to_s
      row = Database.execute("SELECT #{attributes_keys.join(',')}
      FROM #{@table} WHERE #{key} = ?", value).first
      map_object(row)
    end

    def self.all
      data = Database.execute "SELECT #{attributes_keys.join(',')}
      FROM #{@table} ORDER BY id DESC"
      data.map do |row|
        map_object(row)
      end
    end

    def self.where(query_pattern, value)
      data = Database.execute "SELECT #{attributes_keys.join(',')} FROM
      #{@table} WHERE #{query_pattern}", value
      data.map do |row|
        map_object(row)
      end
    end

    def self.last
      query = "SELECT * FROM #{@table} ORDER BY id DESC LIMIT 1"
      row = (Database.execute query).first
      map_object(row)
    end

    def self.first
      query = "SELECT * FROM #{@table} ORDER BY id LIMIT 1"
      row = (Database.execute query).first
      map_object(row)
    end

    def self.find(id)
      row = Database.execute("SELECT #{attributes_keys.join(',')}
      FROM #{@table} WHERE id = ?", id).first
      map_object(row)
    end

    def self.destroy(id)
      Database.execute "DELETE FROM #{table_name} WHERE id = ?", id
    end

    def save
      table_name = self.class.table_name
      if id
        Database.execute "UPDATE #{table_name} SET
        #{update_records_placeholders} WHERE id = ?", update_records
      else
        Database.execute "INSERT INTO #{table_name} (#{get_columns})
        VALUES  (#{new_record_placeholders})", new_record_value
      end
    end

    def update(params)
      table_name = self.class.table_name
      Database.execute "UPDATE #{table_name} SET
      #{update_values_placeholders(params)} WHERE id=?", update_values(params)
    end

    def destroy
      table_name = self.class.table_name
      Database.execute "DELETE FROM #{table_name} WHERE id = ?", id
    end

    def self.destroy_all
      Database.execute "DELETE FROM #{@table}"
    end
  end
end
