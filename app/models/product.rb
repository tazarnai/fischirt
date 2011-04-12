class Product < ActiveRecord::Base
	default_scope :order => 'title'

  has_many :line_items

  before_destroy :ensure_no_referenced_line_item

  def ensure_no_referenced_line_item
    if line_items.count.zero?
      return true
    else
      error.add(:base, 'Line Item present')
      return false
    end
  end

	validates :title, :description, :image_url, :presence => true 
	
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	
	validates :title, :uniqueness => true
	
	validates :image_url, :format => {
				:with => %r{\.(gif|jpg|png)$}i,
				:message => 'must be a URL for GIF, JPG or PNG image.'
			}
end
