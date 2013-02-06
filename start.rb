require './require_all'

class StartQT4 < Qt::MainWindow
  attr_reader :hopfild_net, :images_builder

  include Slots

  def initialize parent=nil
    super
    @ui = Ui_NetManager.new
    @ui.setupUi self
    initialize_view
  end

  private

  def initialize_view
    view = @ui.graphicsView
    @scene = Qt::GraphicsScene.new(0, 0, 300, 300)
    view.setScene @scene
    view.cacheMode = Qt::GraphicsView::CacheBackground
    view.viewportUpdateMode = Qt::GraphicsView::FullViewportUpdate
    view.dragMode = Qt::GraphicsView::ScrollHandDrag
  end
end

if $0 == __FILE__
  app = Qt::Application.new(ARGV)
  myapp = StartQT4.new
  myapp.show
  app.exec
end