/*******************************************************************************
 # File        : KCImagePicker.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/14
 # Corporation : ****
 # Description : 相册图片获取

 获取单张图片
 KCImagePicker.share.pickSingle(presentVC: self) { (image) in
 }

 获取多张图片
 KCImagePicker.share.pickMultiple(presentVC: self) { (images) in
 }

 ******************************************************************************/

import UIKit
import Fusuma

class KCImagePicker: Any, FusumaDelegate {

    static let share = KCImagePicker()

    private var singleBlock: ((_ image: UIImage) -> Void)?
    private var multipleBlock: ((_ images: [UIImage]) -> Void)?

    func pickSingle(presentVC: UIViewController, complection: ((_ image: UIImage) -> Void)?) {
        self.singleBlock = complection

        let pickerVC = FusumaViewController()
        pickerVC.delegate = self

        presentVC.present(pickerVC, animated: true, completion: nil)
    }

    func pickMultiple(presentVC: UIViewController, complection: ((_ images: [UIImage]) -> Void)?) {
        self.multipleBlock = complection

        let pickerVC = FusumaViewController()
        pickerVC.delegate = self
        pickerVC.allowMultipleSelection = true

        presentVC.present(pickerVC, animated: true, completion: nil)
    }

    // FusumaDelegate

    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        singleBlock?(image)
    }

    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        multipleBlock?(images)
    }

    func fusumaCameraRollUnauthorized() {

    }

    func fusumaVideoCompleted(withFileURL fileURL: URL) {}
}
