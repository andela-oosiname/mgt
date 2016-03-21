class Todo < Mgt::ActiveRecord
  table :todos
  attribute :id, type: :integer, primary_key: true
  attribute :title, type: :text, nullable: false
  attribute :body, type: :text, nullable: false
  attribute :status, type: :text, nullable: false
  attribute :created_at, type: :text, nullable: false
  create_table
end
