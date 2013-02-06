class ImagesBuilder
  attr_reader :test_images, :recognize_images, :pixels_count, :width

  def initialize(image_size)
    self.image_size = image_size
    @test_images, @recognize_images = [], []
    @pixels_count = image_size[0] * image_size[1]
  end

  def build(numbers, type)
    image_model = ImageModel.new(numbers, width/10)
    get_container(type) << ImageView.new(0, 0, @width, @height, image_model)
  end

  def allocate_on(scene, pos_x, pos_y, type)
    get_container(type).each_with_index do |image, idx|
      image.pos = Qt::PointF.new(pos_x, pos_y + offset_y*idx)
      scene.addItem(image)
    end

    scene.sceneRect =  Qt::Rect.new(0, 0, 300, pos_y + offset_y * test_images.size)
  end

  def allocate_image_on(scene, pos_x, pos_y)
    image = test_images.last
    image.pos = Qt::PointF.new(pos_x, pos_y + offset_y * (test_images.size - 1))
    scene.addItem(image)

    p offset_y
    scene.sceneRect =  Qt::Rect.new(0, 0, 300, pos_y + offset_y * test_images.size)
  end

  def clear_from(scene, type)
    get_container(type).each { |image| scene.removeItem(image) }.clear
  end

  def image_size
    [@width, @height]
  end

  def to_matrix(type)
    Matrix[*get_container(type).map(&:to_a)]
  end

  def recognize_with(neuro_net)
    numbers_array = test_images.map { |image| neuro_net.recognize(image) }

    numbers_array.each do |numbers|
      image_model = ImageModel.new(numbers, width/10)
      recognize_images << ImageView.new(0, 0, @width, @height, image_model)
    end
  end

  def clear_all(scene)
    clear_from(scene, :recognize_image)
    clear_from(scene, :test_image)
  end

  def image_size=(size)
    @width, @height = *size.map { |el| el * Pixel.size }
  end

  def size
    image_size.map { |el| el/Pixel.size  }
  end

  private

  def get_container(type)
    type == :test_image ? test_images : recognize_images
  end

  def offset_y
    @height  + 10
  end
end