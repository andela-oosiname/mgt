module OriginSpecHelper
  def seed(n = 1)
    titles = %w(task1 task2 task3 task4 task5 task6 task7 task8 task9 task10)
    bodies = %w(body1 body2 body3 body4 body5 body6 body7 body8 body9 body10)
    (0...n).each  do |i|
      todo = Todo.new
      todo.title = titles[i]
      todo.body =  bodies[i]
      todo.status = "pending"
      todo.created_at = Time.now.to_s
      todo.save
    end
  end
end
