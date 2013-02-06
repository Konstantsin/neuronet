class ImagesArea < Qt::GraphicsView
  def drawBackground(painter, rect)
    gradient = Qt::LinearGradient.new(sceneRect.topLeft, sceneRect.bottomRight)
    gradient.setColorAt(0, Qt::Color.new(Qt::white))
    gradient.setColorAt(1, Qt::Color.new(Qt::lightGray))

    painter.fillRect(sceneRect, Qt::Brush.new(gradient))
    painter.brush = Qt::NoBrush
    painter.drawRect(sceneRect)
  end
end
