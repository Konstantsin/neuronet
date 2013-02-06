
class Ui_NetManager
  attr_reader :actionLoad
  attr_reader :actionSave
  attr_reader :actionCreate_image
  attr_reader :actionLearn
  attr_reader :actionRecognize
  attr_reader :centralWidget
  attr_reader :graphicsView
  attr_reader :menuBar
  attr_reader :mainToolBar
  attr_reader :statusBar
  attr_reader :toolBar

  def setupUi(netManager)
    if netManager.objectName.nil?
      netManager.objectName = "netManager"
    end
    netManager.resize(347, 361)

    @actionLoad = Qt::Action.new(netManager)
    @actionLoad.objectName = "actionLoad"
    @actionSave = Qt::Action.new(netManager)
    @actionSave.objectName = "actionSave"
    @actionCreate_image = Qt::Action.new(netManager)
    @actionCreate_image.objectName = "actionCreate_image"
    @actionLearn = Qt::Action.new(netManager)
    @actionLearn.objectName = "actionLearn"
    @actionRecognize = Qt::Action.new(netManager)
    @actionRecognize.objectName = "actionRecognize"
    @actionClearAll = Qt::Action.new(netManager)
    @actionClearAll.objectName = "actionClearAll"

    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)

    @graphicsView = ImagesArea.new(netManager)
    @graphicsView.objectName = "graphicsView"
    @graphicsView.geometry = Qt::Rect.new(10, 0, 329, 269)
    @graphicsView.sizePolicy = @sizePolicy
    @graphicsView.minimumSize = Qt::Size.new(256, 0)
    @graphicsView.autoFillBackground = true
    @graphicsView.resizeAnchor = Qt::GraphicsView::AnchorViewCenter
    netManager.centralWidget = @graphicsView
    @menuBar = Qt::MenuBar.new(netManager)
    @menuBar.objectName = "menuBar"
    @menuBar.geometry = Qt::Rect.new(0, 0, 347, 25)
    netManager.setMenuBar(@menuBar)
    @mainToolBar = Qt::ToolBar.new(netManager)
    @mainToolBar.objectName = "mainToolBar"
    netManager.addToolBar(Qt::TopToolBarArea, @mainToolBar)
    @statusBar = Qt::StatusBar.new(netManager)
    @statusBar.objectName = "statusBar"
    netManager.statusBar = @statusBar
    @toolBar = Qt::ToolBar.new(netManager)
    @toolBar.objectName = "toolBar"
    netManager.addToolBar(Qt::TopToolBarArea, @toolBar)

    @mainToolBar.addAction(@actionLoad)
    @mainToolBar.addAction(@actionSave)
    @mainToolBar.addAction(@actionCreate_image)
    @mainToolBar.addAction(@actionLearn)
    @mainToolBar.addAction(@actionRecognize)
    @mainToolBar.addAction(@actionClearAll)

    retranslateUi(netManager)
    Qt::Object.connect(@actionLoad, SIGNAL('triggered()'), netManager, SLOT('loadImages()'))
    Qt::Object.connect(@actionLearn, SIGNAL('triggered()'), netManager, SLOT('learnNet()'))
    Qt::Object.connect(@actionRecognize, SIGNAL('triggered()'), netManager, SLOT('recognizeImages()'))
    Qt::Object.connect(@actionSave, SIGNAL('triggered()'), netManager, SLOT('saveImages()'))
    Qt::Object.connect(@actionCreate_image, SIGNAL('triggered()'), netManager, SLOT('createImage()'))
    Qt::Object.connect(@actionClearAll, SIGNAL('triggered()'), netManager, SLOT('clearAll()'))


    Qt::MetaObject.connectSlotsByName(netManager)
  end # setupUi

  def setup_ui(netManager)
    setupUi(netManager)
  end

  def retranslateUi(netManager)
    netManager.windowTitle = translate("NetManager", "NetManager")
    @actionLoad.text = "load"
    @actionLoad.shortcut = translate("NetManager", "Ctrl+O")
    @actionSave.text = "save"
    @actionSave.shortcut = translate("NetManager", "Ctrl+S")
    @actionCreate_image.text = "create image"
    @actionCreate_image.shortcut = translate("NetManager", "Ctrl+N")
    @actionLearn.text = "learn"
    @actionLearn.shortcut = translate("NetManager", "Ctrl+L")
    @actionRecognize.text = "recognize"
    @actionSave.text = "save"
    @toolBar.windowTitle = translate("NetManager", "toolBar")
    @actionClearAll.text = "clear all"
  end

  def retranslate_ui(netManager)
    retranslateUi(netManager)
  end

  def translate(name, value)
    Qt::Application.translate(name, value, nil, Qt::Application::UnicodeUTF8)
  end

end

module Ui
  class NetManager < Ui_NetManager
  end
end

