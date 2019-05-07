/*******************************************************************************
 # File        : KCEditAlertView.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/17
 # Corporation : ****
 # Description : 带输入框的弹窗
 ******************************************************************************/

import UIKit

class KCEditAlertView: KCAlertView {
    var inputTF: UITextField?  // 输入框

    private var placeHolder: String = ""
    private var tips: String = ""

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /**
     * 显示输入框弹窗
     * @params
     * placeHolder: 输入框的默认提示文案
     * tips: 提示文案, 文字内容前会有一个小圆点
     * 其他参数参看父类
     */
    static func show(title: String,
                     placeHolder: String? = nil,
                     tips: String? = nil,
                     icon: String? = nil,
                     actions: [String]? = nil,
                     specialIndex: Int = -1,
                     complection: ((_ index: Int) -> Void)? = nil) {

        let instance = KCEditAlertView(title: title,
                                       icon: icon,
                                       actions: actions,
                                       specialIndex: specialIndex,
                                       complection: complection)

        NotificationCenter.default.addObserver(instance,
                                               selector: #selector(_keyBoardWillShow(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)

        instance.placeHolder = placeHolder ?? ""
        instance.tips = tips ?? ""
        instance.useBaseAnimation = false // 禁止基类的动画，自定义弹出动画，原因是为了配合键盘弹出
        instance.show()
    }

    override func initMidContent() {
        contentHeight += 16

        let x: CGFloat = 20
        let width: CGFloat = contentView.bounds.size.width - x * 2

        let inputContainer = UIView(frame: CGRect(x: x,
                                                  y: contentHeight,
                                                  width: width,
                                                  height: 38))
        inputContainer.layer.borderWidth = 0.5
        inputContainer.layer.borderColor = UIColor.hex(value: 0xD4DAEC).cgColor
        contentView.addSubview(inputContainer)
        contentHeight += 38

        let inputTF = UITextField(frame: CGRect(x: 4,
                                                y: 0,
                                                width: width - 8,
                                                height: 38))
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.pingFangWith(size: 14),
            .foregroundColor: UIColor.hex(value: 0xD4DAEC)
        ]
        inputTF.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                           attributes: attributes)
        inputContainer.addSubview(inputTF)

        if tips.count > 0 {
            contentHeight += 16

            let attrStr = NSAttributedString(string: "• \(tips)",
                attributes: [.font: UIFont.pingFangWith(size: 14), .foregroundColor: UIColor.hex(value: 0x677282)])
            let height = attrStr.boundingRect(with: CGSize(width: width, height: 200), options: [.usesLineFragmentOrigin], context: nil).size.height
            let tipsLab = UILabel(frame: CGRect(x: x, y: contentHeight, width: width, height: height))
            contentView.addSubview(tipsLab)

            tipsLab.attributedText = attrStr
            contentHeight += height
        }

        DispatchQueue.main.async {
            inputTF.becomeFirstResponder()
        }
    }

    @objc private func _keyBoardWillShow(_ notification: Notification) {
        let kbInfo = notification.userInfo
        guard let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let screenHeight = UIScreen.main.bounds.size.height
        var frame = contentView.frame
        frame.origin.y = screenHeight
        contentView.frame = frame

        frame.origin.y = screenHeight - kbRect.size.height - 20 - frame.size.height

        let duration = (kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0

        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.contentView.frame = frame
            self?.alpha = 1
        }, completion: nil)
    }
}
