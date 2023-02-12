//
//  MoreReviewDetailViewController.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit

class MoreReviewDetailViewController: BaseViewController {
    @IBOutlet weak var reviewContentView: UIView!
    @IBOutlet weak var avatarReviewImageView: UIImageView!
    @IBOutlet weak var reviewWriteByLbl: UILabel!
    @IBOutlet weak var reviewDateLbl: UILabel!
    @IBOutlet weak var reviewTextLbl: UILabel!
    
    var data: MovieReviewModel.Review?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    private func dropShadow() {
        reviewContentView.layer.cornerRadius = 8
        let grayColor = UIColor.init(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        reviewContentView.layer.borderColor = grayColor.cgColor
        reviewContentView.layer.applySketchShadow(color: grayColor, alpha: 1.0, x: 0, y: 1, blur: 4, spread: 0)
    }
    
    private func setupData() {
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
        }
    }
}
