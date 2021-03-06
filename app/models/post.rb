class Post < ActiveRecord::Base
    include ActiveModel::Validations
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validates :title_include

    CLICKBAIT_PATTERNS = [
        "Won't Believe",
        "Secret",
        "Top[number]",
        "Guess"
    ]
    def title_include
        if title.present? && CLICKBAIT_PATTERNS.none? {|p| title.match(p)}
            errors.add(:title, "title not clickbait-y enough")
        end
    end
end
