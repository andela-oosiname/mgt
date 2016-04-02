module Mgt
  class Database
    class << self
      attr_accessor :db

      def connect
        @db = SQLite3::Database.new File.join "app.db"
      end

      def execute(query, args = nil)
        @db ||= connect
        return @db.execute(query, args) if args
        @db.execute(query)
      end
    end
  end
end
