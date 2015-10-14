require "csv"

class Fortune
  FILENAME = "fortunes.csv"

  class << self
    def all
      result = []
      CSV.foreach(FILENAME, headers: true) do |row|
        result << Fortune.new(row["id"], row["text"])
      end
      result
    end

    def sample
      all.sample
    end

    def read(id)
      all.find { |fortune| fortune.id == id }
    end

    def create(text)
      last_id = all.last.id
      fortune = Fortune.new(last_id.to_i + 1, text)
      CSV.open(FILENAME, "a") do |csv|
        csv << fortune.to_a
      end
      fortune
    end

    def update(id, text)
      fortunes = all
      fortunes.each do |fortune|
        if fortune.id == id
          fortune.text = text
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
        csv << ["id", "text"]
        fortunes.each do |fortune|
          csv << fortune.to_a
        end
      end
    end
  end

  attr_reader :id
  attr_accessor :text

  def initialize(id, text)
    @id = id
    @text = text
  end

  def to_json
    { id: id, text: text }.to_json
  end

  def to_a
    [id, text]
  end
end
