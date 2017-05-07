class Article < ActiveRecord::Base
  # For more information on Active Record associations, see the Active Record Associations guide.
  # http://guides.rubyonrails.org/v4.2/association_basics.html
  has_many :comments, dependent: :destroy
  # For more on validation see:
  # http://guides.rubyonrails.org/v4.2/active_record_validations.html
  validates :title, presence: true,
                    length: { minimum: 5 }
end
