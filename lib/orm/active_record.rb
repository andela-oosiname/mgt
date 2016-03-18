require "sqlite3"

module Mgt
  class ActiveRecord
    def self.table(table_name)
      @table = table_name
    end

    def self.table_name
      @table
    end

    def self.attribute(column_name, args)
      @attributes ||= {}
      @attributes[column_name] = args
    end

    def self.create_table
      all_attributes = []
      @attributes.each do |key, value|
        attributes ||= []
        attributes << key.to_s
        value.each do |name, type|
          attributes << send("#{name.downcase}_query", type)
        end
        all_attributes << attributes.join(" ")
      end
      query = "CREATE TABLE IF NOT EXISTS #{@table} (#{all_attributes.join(', ')})"
      Database.execute(query)
      make_methods
    end

    def self.make_methods
      mtds = @attributes.keys.map(&:to_sym)
      mtds.each { |mtd| attr_accessor mtd }
    end

    def self.primary_key_query(value = false)
      "PRIMARY KEY AUTOINCREMENT" if value
    end

    def self.nullable_query(value = true)
      "NOT NULL" unless value
    end

    def self.type_query(value)
      value.to_s
    end

    def self.attributes_keys
      @attributes.keys
    end

    def self.map_object(row)
      model_name = new
      @attributes.each_key.with_index do |value, index|
        model_name.send("#{value}=", row[index])
      end
      model_name
    end

    def get_columns
      columns = self.class.attributes_keys
      columns.delete(:id)
      columns.join(",")
    end

    def get_values
      attributes = self.class.attributes_keys
      attributes.delete(:id)
      # send sends a message to an object instance and its ancestors in class hierarchy until some method reacts (because its name matches the first argument).
      attributes.map { |method| send(method) }
    end

    def new_record_value
      get_values
    end

    def update_records
      get_values << send(:id)
    end

    def update_values(params)
      params.values << id
    end

    def new_record_placeholders
      attributes = self.class.attributes_keys
      (["?"] * (attributes.size - 1)).join(",")
    end

    def update_values_placeholders(params)
      columns = params.keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def update_records_placeholders
      columns = self.class.properties_keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end
  end
end
