module Slots

  def self.included(base)
    base.class_eval do
      slots 'loadImages()', 'createImage()',     'saveImages()',
            'learnNet()',   'recognizeImages()', 'clearAll()'
    end
  end

  def loadImages
    if filename = Qt::FileDialog.getOpenFileName
      load(filename)
      images_builder.allocate_on(@scene, 10, 10, :test_image)
    end
  end

  def createImage
    if size = Ui::CreateDialog.getSizeOfImage(self)
      @images_builder ||= ImagesBuilder.new(size)
      width, height = *size
      @images_builder.build(Array.new(width * height) { 1 }, :test_image)
      @images_builder.allocate_image_on(@scene, 10, 10)
    end
  end

  def saveImages
    if filename = Qt::FileDialog.getSaveFileName
      save(filename)
    end
  end

  def learnNet
    data = images_builder.to_matrix(:test_image)

    @hopfild_net = HopfildNeuroNet.new(images_builder.pixels_count)
    @hopfild_net.learn(data)
  end

  def recognizeImages
    images_builder.clear_from(@scene, :recognize_image)
    images_builder.recognize_with(@hopfild_net)

    pos = [20 + images_builder.width, 10]
    images_builder.allocate_on(@scene, *pos, :recognize_image)
  end

  def clearAll
    images_builder.clear_all(@scene) unless images_builder.nil?
    @images_builder = nil
  end

  private

  def load(filename)
    File.open(filename) do |file|
      image_size = file.gets.split(', ').map &:to_i
      @images_builder = ImagesBuilder.new(image_size)

      while line = file.gets
        @images_builder.build(line.split(', ').map(&:to_i), :test_image)
      end
    end
  end

  def save(filename)
   File.open(filename, 'w') do |file|
     file.puts images_builder.size.join(", ")

     images_builder.test_images.each { |img| img.save(file) }
    end
  end
end

