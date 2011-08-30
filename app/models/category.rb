class Category < ActiveRecord::Base
  has_many :products
  has_many :categories
  belongs_to :category

  validates_presence_of :name
  validates_presence_of :description

  def parent
    category
  end

  def children
    categories
  end

  def path
    @path = [self]
    @parent = parent
    while @parent
      @path << @parent
      @parent = @parent.parent
    end
    @path.reverse
  end
end
