//
//  HomeCollectionViewCell.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(data: MovieListModel.Datum?) {
        if let validData = data {
            let url = Constants.imageHost + (validData.poster_path ?? "")
            movieImageView.loadImage(url: URL(string: url))
        }
    }
}
