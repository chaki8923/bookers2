class ViewCount < ApplicationRecord
  belongs_to :book
  belongs_to :user

  def self.increment_count(book)
    view_count = find_or_initialize_by(book_id: book.id)
    view_count.increment!(:count)
  end
end
