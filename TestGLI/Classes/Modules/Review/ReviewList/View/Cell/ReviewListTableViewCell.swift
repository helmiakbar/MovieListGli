//
//  ReviewListTableViewCell.swift
//  TestGLI
//
//  Created by SehatQ on 12/02/23.
//

import UIKit

protocol ReviewListTableCellDelegate {
    func didTapMore(index: Int)
}

class ReviewListTableViewCell: UITableViewCell {
    @IBOutlet weak var reviewContentView: UIView!
    @IBOutlet weak var avatarReviewImageView: UIImageView!
    @IBOutlet weak var reviewWriteByLbl: UILabel!
    @IBOutlet weak var reviewDateLbl: UILabel!
    @IBOutlet weak var reviewTextLbl: UILabel!
    
    var index = 0
    var delegate: ReviewListTableCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func dropShadow() {
        reviewContentView.layer.cornerRadius = 8
        let grayColor = UIColor.init(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        reviewContentView.layer.borderColor = grayColor.cgColor
        reviewContentView.layer.applySketchShadow(color: grayColor, alpha: 1.0, x: 0, y: 1, blur: 4, spread: 0)
    }
    
    func setupData(data: MovieReviewModel.Review?, index: Int) {
        self.index = index
        dropShadow()
        if let validResult = data {
            var url = ""
            if (validResult.author_details?.avatar_path ?? "").contains("https://") {
                url = validResult.author_details?.avatar_path ?? ""
            } else {
                url = Constants.imageHost + (validResult.author_details?.avatar_path ?? "")
            }
            avatarReviewImageView.loadImage(url: URL(string: url))
            reviewWriteByLbl.text = "A Review by \(validResult.author_details?.username ?? "")"
            var validCreatedString = ""
            if let validCreatedDate = validResult.created_at, let validDate = CustomDateFormatter.yyyy_dash_MM_dash_dd_T_HH_colon_mm_colon_ss_dot_SSSZ.dateFromString(validCreatedDate) {
                validCreatedString = CustomDateFormatter.MMM_dd_comma_yyyy.stringFromDate(validDate)
            }
            reviewDateLbl.text = "Written by \(validResult.author_details?.username ?? "") on \(validCreatedString)"
            
            if let htmlString = validResult.content, let attrString = htmlString.htmlToAttributedString {
                let attributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                ] as [NSAttributedString.Key: Any]
                attrString.addAttributes(attributes, range: NSMakeRange(0, attrString.length))
                reviewTextLbl.attributedText = attrString
            } else {
                reviewTextLbl.text = nil
            }
            
            if reviewTextLbl.numberOfVisibleLines > 7 {
                let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 11.0)
                let readmoreFontColor = UIColor.blue
                DispatchQueue.main.async {
                    self.reviewTextLbl.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
                }
                
                let tap = UITapGestureRecognizer(target: self, action:#selector(tapMore(_:)))
                reviewTextLbl.isUserInteractionEnabled = true
                reviewTextLbl.addGestureRecognizer(tap)
            }
        }
    }
    
    @objc func tapMore(_ sender: UITapGestureRecognizer) {
        delegate?.didTapMore(index: index)
    }
}
