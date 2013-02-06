class ImageView < Qt::GraphicsRectItem

  def initialize(x, y, w, h, model)
    super(x, y, w, h)
    @model = model
    self.acceptHoverEvents = true
    @rect = Qt::Rect.new(0, 0, w, h)
  end

  def paint(painter, style, widget)
    painter.pen = pen
    @model.draw(painter, self)
  end

  def mousePressEvent(event)
    @model.click(event.pos.x, event.pos.y)
    scene.update

    super(event)
  end

  def hoverEnterEvent(event)
    Qt::Application.setOverrideCursor(Qt::Cursor.new(Qt::PointingHandCursor))
  end

  def hoverLeaveEvent(event)
    Qt::Application.restoreOverrideCursor
  end

  def save(file)
    @model.save(file)
  end

  def to_a
    @model.to_a
  end

  def to_matrix
    Matrix[to_a]
  end
end
