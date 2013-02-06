class ImageModel

  attr_accessor :width

  def initialize(data, width)
    @pixels_in_row = width
    @width = @pixels_in_row * Pixel.size
    make_pixels(data)
  end

  def draw(painter, scene)
    @pixels.each { |px| px.draw(painter, scene) }
  end

  def click(x, y)
    @pixels.each { |px| px.click(x, y) }
  end

  def save(file)
    file.puts to_a.join(", ")
  end

  def to_a
    @pixels.map(&:sign)
  end

  private

  def make_pixels(data)
    @pixels = []

    data.each_slice(@pixels_in_row).with_index do |row, i|
      row.each_with_index do |el, j|
        @pixels << Pixel.new(i, j, el)
      end
    end
  end
end

