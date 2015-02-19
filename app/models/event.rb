class Event < ActiveRecord::Base
  has_attached_file :image, :styles => { :large =>"600x600" , :medium => "300x300>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
  	Tag.find_by_name!(name).events
  end

  def self.tag_counts
  	Tag.select("tags.*, count(taggings.tag_id) as count").
  		joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
  	tags.map(&:name).join(", ")
  end

  def tag_list=(names)
  	self.tags = names.split(",").map do |n|
  		Tag.where(name: n.strip).first_or_create!
  	end
  end
end
