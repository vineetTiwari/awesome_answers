class Question < ActiveRecord::Base
	validates :title, presence: true, uniqueness: {scope: :body, case_sensitive: false }
	validates :body, presence: {message: "must be provided!"}, uniqueness: true
	validates :view_count, numericality: {greater_than_or_equal_to: 0}
	validate :stop_words
	after_initialize :set_defaults
	before_save :capitalize_title

	scope :recent, lambda {|x| order("updated_at DESC").limit(x) }
		#def self.recent(number)
		#order("updated_at DESC").limit(number)
		#end

	#scope :recent, lambda {|x| order("created_at DESC").limit(x) }

	def self.last_days(num)
	   where("created_at >?", num.days.ago)
	end

	private

	def stop_words
		if title.present? && title.include?("monkey")
		errors.add(:title, "Monkey is not allowed!") 
		end
	end

	def set_defaults
		self.view_count ||= 0
	end

	def capitalize_default
		self.title.capitalize!
	end
end
