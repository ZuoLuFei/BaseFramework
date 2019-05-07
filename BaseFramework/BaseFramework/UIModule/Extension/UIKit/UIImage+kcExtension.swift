/*******************************************************************************
 # File        : UIImage+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import Foundation

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }

    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize: CGFloat) -> UIImage {
        let reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
