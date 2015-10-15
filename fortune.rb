require "csv"

class Fortune
  FILENAME = "fortunes.csv"

  class << self
    def all
      result = []
      CSV.foreach(FILENAME, headers: true) do |row|
        result << Fortune.new(row["id"], row["content"])
      end
      result
    end

    def sample
      all.sample
    end

    def read(id)
      all.find { |fortune| fortune.id == id }
    end

    def create(content)
      last_id = all.last.id
      fortune = Fortune.new(last_id.to_i + 1, content)
      CSV.open(FILENAME, "a") do |csv|
        csv << fortune.to_a
      end
      fortune
    end

    def update(id, content)
      fortunes = all
      fortunes.each do |fortune|
        if fortune.id == id
          fortune.content = content
          break
        end
      end
      write(fortunes)
    end

    def delete(id)
      fortunes = all
      fortunes.reject! { |fortune| fortune.id == id }
      write(fortunes)
    end

    private
    def write(fortunes)
      CSV.open(FILENAME, "w") do |csv|
        csv << ["id", "content"]
        fortunes.each do |fortune|
          csv << fortune.to_a
        end
      end
    end
  end

  attr_reader :id
  attr_accessor :content

  def initialize(id, content)
    @id = id
    @content = content
  end

  def to_json
    { id: id, content: content }.to_json
  end

  def to_a
    [id, content]
  end
end
