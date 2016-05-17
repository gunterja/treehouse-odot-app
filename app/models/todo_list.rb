class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items
  validates :title, presence: :true, length: { minimum: 3 }
  validates :description, presence: :true, length: { minimum: 5 }

  def has_complete_items?
    todo_items.complete.size > 0
  end

  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end
end
