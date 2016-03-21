require "spec_helper"
describe "Create Todo Spec", type: :feature do
  def seed(n = 1)
    n.times do
      todo = Todo.new
      todo.title = %w(task1 task2 task3).sample
      todo.body =  %w(body1 body2 body3).sample
      todo.status = "pending"
      todo.created_at = Time.now.to_s
      todo.save
    end
  end
  after(:each) do
    Todo.destroy_all
  end
  it "has index page" do
    seed
    visit "/todo"
    expect(page).to have_selector(".add-button")
    expect(page).to have_content("Total Tasks")
    expect(page).to have_content(Todo.last.title)
  end

  it "creates a new todo" do
    visit "/todo/new"
    expect(page).to have_selector(".btn-primary")
    fill_in("title", with: "Holiday")
    fill_in("body", with: "Take a trip to Barbados")
    click_button("Add New Todo")
    visit "/todo"
    expect(page).to have_content("Holiday")
  end

  it "updates todo" do
    seed
    visit "/todo"

    expect(page).to have_content(Todo.last.title)
    first(".edit").click
    fill_in("title", with: "get carton")
    fill_in("body", with: "Take a trip to Barbados")
    click_button("Update Todo")
    expect(Todo.last.title).to eq "get carton"
  end

  it "deletes a todo" do
    seed 10
    visit "/todo"

    expect(page).to have_content(Todo.first.title)
    first(".delete").click
    expect(Todo.all.length).to eq 9
  end

  it "shows a todo" do
    seed 10
    visit "/todo"

    first(".view").click
    expect(page).to have_content(Todo.last.title)
  end
end
