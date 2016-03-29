require "spec_helper"
require_relative "../unit/origin_spec_helper"
describe "Todo Spec", type: :feature do
 include OriginSpecHelper
  after(:each) do
    Todo.destroy_all
  end
  it "has index page" do
    visit "/todo"

    expect(page).to have_selector(".add-button")
    expect(page).to have_content("Total Tasks")
  end

  it "creates a new todo" do
    visit "/todo/new"
    expect(page).to have_selector(".btn-primary")
    fill_in("title", with: "Holiday")
    fill_in("body", with: "Take a trip to Barbados")
    click_button("Add New Todo")

    expect(page).to have_content("Holiday")
  end

  it "updates todo" do
    seed
    visit "/todo"

    first(".edit").click
    fill_in("title", with: "get carton")
    fill_in("body", with: "Take a trip to Barbados")
    click_button("Update Todo")

    expect(Todo.last.title).to eq "get carton"
  end

  it "deletes a todo" do
    seed 10
    visit "/todo"

    first(".delete").click
    expect(Todo.all.length).to eq 9
  end

  it "shows a todo" do
    seed 10
    visit "/todo"

    first(".view").click
    expect(page).to have_content(Todo.last.title)
  end

  it "renders 404 page if path doesnt exist" do
    visit "/todoss"

    expect(page).to have_content("Page not found")
  end
end
