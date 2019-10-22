require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    # .freeze renders a constant immutable.
    # %w makes it an array
    CAT_COLORS = %w(black white orange brown).freeze

    validates :birth_date, :color, :name, :sex, presence: true
    validates :color, inclusion: CAT_COLORS
    validates :sex, inclusion: %w(M F)
    validate :birth_date_in_the_past, if: -> { birth_date }

    has_many :rental_requests,
        class_name: :CatRentalRequest,
        dependent: :destroy
    
    belongs_to :owner,
        class_name: 'User',
        foreign_key: :user_id

    def age
        time_ago_in_words(birth_date)
    end

    def birth_date_in_the_past
        if birth_date && birth_date > Time.now
            errors[:birth_date] << 'must be in the past'
        end
    end
end