require "spec_helper"
require_relative "active_record_spec_helper"
describe "Active Record queries" do
  include ActiveRecordSpecHelper
  after(:each) do
    Todo.destroy_all
  end

  it " deletes all rows in a table" do
    todo = Todo.new
    todo.title = %w(task1 task2 task3).sample
    todo.body =  %w(body1 body2 body3).sample
    todo.status = "pending"
    todo.created_at = Time.now.to_s
    todo.save
    expect(Todo.all.length).to eq 1
    expect(Todo.destroy_all).to eq []
  end

  it "returns first and last item" do
    seed 3
    expect(Todo.first.nil?).to be false
    expect(Todo.last.nil?).to be false
  end

  it "deletes a row ina table" do
    seed 3
    Todo.last.destroy
    expect(Todo.all.length).to be 2
  end

  it "updates a todo" do
    seed 3
    todo = Todo.first
    todo.title = "new title"
    todo.status = "done"
    todo.body = "new body"
    todo.save
    expect(Todo.first.status).to eq "done"
  end

  it "finds a todo by id" do
    seed 3
    todo = Todo.last
    id = todo.id
    expect(Todo.find(id).nil?).to be false
  end

  it "saves an entry" do
    todo = Todo.new
    todo.title = "newtitle"
    todo.body =  "newbody"
    todo.status = "pending"
    todo.created_at = Time.now.to_s
    todo.save
    expect(Todo.all.length).to be 1
  end

  it "finds a todo by any param" do
    seed 3
    todo = Todo.last

    expect(Todo.find_by(title: todo.title).nil?).to be false
  end

  it "returns all item in the database" do
    seed 4
    expect(Todo.all.length).to eq 4
  end
end
