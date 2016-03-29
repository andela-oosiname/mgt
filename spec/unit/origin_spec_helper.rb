module OriginSpecHelper
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
end
