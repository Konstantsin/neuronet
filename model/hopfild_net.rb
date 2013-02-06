class HopfildNeuroNet
  attr_reader :image_queue

  def initialize(size)
    @size = size
    @wieghts = Matrix.build(size, size) { 0 }
    @image_queue = ImageQueue.new(4)
  end

  def learn(data)
    @old = @wieghts.dup

    0.upto(data.row_size-1) do |i|
      xi = Matrix[data.row(i).to_a].transpose
      calculate_wieghts(*prepare(xi))
    end

    remove_reflection
  end

  def recognize(image)
    @number_of_neurons = (0...@size).to_a

    wait_relaxation(image.to_matrix)
  end

  private

  def wait_relaxation(out_image)
    image_queue.clear

    begin
      image_queue.push out_image.dup
      out_image = asynchronous_recognize(out_image)
    end while image_queue.shift != out_image

    out_image.to_a[0]
  end

  def asynchronous_recognize(out_image)
    @number_of_neurons.shuffle.each do |i|
      input_image = out_image.dup
      el = (input_image * @wieghts.column(i))[0]
      out_image.set(0, i, activation(el))
    end

    out_image
  end

  def calculate_wieghts(old_xi_minus_xi, k)
    @old = @wieghts.dup

    @wieghts = @old + k * old_xi_minus_xi * old_xi_minus_xi.transpose
  end

  def prepare(xi)
    old_xi_minus_xi = (@old * xi - xi)
    k = 1.0/ ((xi.transpose * xi - xi.transpose * @old * xi).first)

    [old_xi_minus_xi, k]
  end

  def remove_reflection
    @wieghts.row_size.times do |i|
      @wieghts.set(i, i, 0)
    end
  end

  def activation(number)
    number > 0 ? 1 : number < 0 ? -1 : number
  end
end
