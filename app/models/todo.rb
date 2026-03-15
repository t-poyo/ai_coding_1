class Todo < ApplicationRecord
  belongs_to :user

  PRIORITIES = { low: 0, medium: 1, high: 2 }.freeze

  enum :priority, PRIORITIES

  validates :title, presence: true
  validates :priority, presence: true

  scope :incomplete, -> { where(completed: false) }
  scope :complete, -> { where(completed: true) }
  scope :by_priority, -> { order(priority: :desc) }
  scope :by_due_date, -> { order(due_date: :asc) }
  scope :overdue, -> { where("due_date < ?", Date.today).where(completed: false) }

  def overdue?
    due_date.present? && due_date < Date.today && !completed?
  end
end
