module Mgt
  class Database
    def self.connect
      @db = SQLite3::Database.new File.join "app.db"
    end

    def self.execute(query, args = nil)
      @db ||= connect
      return @db.execute(query, args) if args
      @db.execute(query)
    end
  end
end
