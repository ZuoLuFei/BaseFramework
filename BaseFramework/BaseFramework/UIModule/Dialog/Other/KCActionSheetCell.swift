/*******************************************************************************
 # File        : KCActionSheetCell.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/17
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

class KCActionSheetCell: UITableViewCell {

    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var splitLine: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.kcBackgroundColor = KCTheme.Color.moduleBg
//        titleLab.kcTextColor = KCTheme.Color.main
//        splitLine.kcBackgroundColor = KCTheme.Color.splitLine
    }
}
