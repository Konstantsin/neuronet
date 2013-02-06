class ImageQueue < Array
  def initialize(min_size = 1)
    @min_size = min_size
    super
  end

  def shift
    size < @min_size ? false : super
  end
end
