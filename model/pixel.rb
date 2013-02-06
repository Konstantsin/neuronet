class Pixel

  attr_reader :sign

  def initialize(y, x, value)
    @sign = value
    @x, @y = x * size, y * size
  end

  def click(x, y)
    if (@x...(@x + size)).include?(x) and (@y...(@y + size)).include?(y)
      @sign = @sign > 0 ? -1 : 1
    end
  end

  def draw(painter, scene)
    painter.brush = brush
    painter.drawRect Qt::Rect.new(@x, @y, size, size)
  end

  def Pixel.size
    @@size ||= 10
  end

  private

  def size
    Pixel.size
  end

  def brush
    @sign > 0 ? wite_brush : black_brush
  end

  def wite_brush
    @@wite_brush ||= Qt::Brush.new(Qt::Color.new(255,255,255))
  end

  def black_brush
    @@black_brush ||= Qt::Brush.new(Qt::Color.new(0,0,0))
  end
end