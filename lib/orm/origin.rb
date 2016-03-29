require "sqlite3"
require_relative "query_generator"

module Mgt
  class Origin < QueryGenerator
    def self.to_table(table_name)
      @table = table_name
    end

    def self.table_name
      @table
    end

    def self.property(column_name, args)
      @properties ||= {}
      @properties[column_name] = args
    end

    def self.create_table
      query = "CREATE TABLE
      IF NOT EXISTS #{@table} (#{get_all_properties.join(', ')})"
      Database.execute(query)
      make_methods
    end

    def self.get_all_properties
      all_properties = []
      @properties.each do |key, value|
        properties ||= []
        properties << key.to_s
        value.each do |name, type|
          properties << send("#{name.downcase}_query", type)
        end
        all_properties << properties.join(" ")
      end
      all_properties
    end

    def self.make_methods
      mtds = @properties.keys.map(&:to_sym)
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

    def self.properties_keys
      @properties.keys
    end

    def self.map_object(row)
      model_name = new
      @properties.each_key.with_index do |value, index|
        model_name.send("#{value}=", row[index])
      end
      model_name
    end

    def get_columns
      columns = self.class.properties_keys
      columns.delete(:id)
      columns.join(",")
    end

    def get_values
      properties = self.class.properties_keys
      properties.delete(:id)
      properties.map { |method| send(method) }
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
      properties = self.class.properties_keys
      (["?"] * (properties.size - 1)).join(",")
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
