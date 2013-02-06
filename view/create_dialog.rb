class Ui_Dialog
    attr_reader :buttonBox
    attr_reader :label
    attr_reader :lineEdit
    attr_reader :dialog

    def setupUi(dialog)
    if dialog.objectName.nil?
        dialog.objectName = "dialog"
        @dialog = dialog
    end
    dialog.resize(188, 76)
    @buttonBox = Qt::DialogButtonBox.new(dialog)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(0, 40, 181, 32)
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @label = Qt::Label.new(dialog)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(10, 10, 66, 17)
    @lineEdit = Qt::LineEdit.new(dialog)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(40, 6, 140, 27)

    retranslateUi(dialog)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), dialog, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), dialog, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(dialog)
    end # setupUi

    def setup_ui(dialog)
        setupUi(dialog)
    end

    def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("Dialog", "Size", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(dialog)
        retranslateUi(dialog)
    end


end

module Ui
  class CreateDialog < Ui_Dialog
    def initialize(parent)
        setup_ui Qt::Dialog.new(parent)
        super()
    end

    def getSizeOfImage
      if(@dialog.exec() == Qt::Dialog::Accepted)
        @lineEdit.text.split.map &:to_i
      end
    end

    def self.getSizeOfImage(parent)
      self.new(parent).getSizeOfImage
    end
  end
end
