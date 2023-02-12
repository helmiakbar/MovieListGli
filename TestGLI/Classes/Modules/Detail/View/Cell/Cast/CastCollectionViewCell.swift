//
//  CastCollectionViewCell.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var characterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.cornerRadius = 8
        let grayColor = UIColor.init(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        shadowView.layer.borderColor = grayColor.cgColor
        shadowView.layer.applySketchShadow(color: grayColor, alpha: 1.0, x: 0, y: 1, blur: 4, spread: 0)
    }
    
    func setupData(data: MovieCreditResponseModel.Cast?) {
        if let validData = data {
            let url = Constants.imageHost + (validData.profile_path ?? "")
            avatarImageView.loadImage(url: URL(string: url))
            nameLbl.text = validData.name
            characterLbl.text = validData.character
        }
    }

}
