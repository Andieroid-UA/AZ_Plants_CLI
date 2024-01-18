class Plant
  attr_accessor :name, :scientific_name

  @@all = []

  def initialize(name, scientific_name = nil)
    @name = name
    @scientific_name = scientific_name
    @@all << self
  end

  def self.all
    @@all
  end

  def to_s
    "Plant: #{@name}"
  end
end
