//
//  UIView+Toast.swift
//  TestGLI
//
//  Created by SehatQ on 12/02/23.
//

import UIKit

enum ToastType {
    case positive
    case negative
}

extension UIView {
    
    func showToastImageTop(size: CGSize, origin: CGPoint, message: String, image: UIImage?) {
        let toast = UIView()
        toast.frame.size = size
        toast.frame.origin = CGPoint(x: origin.x - toast.frame.width / 2, y: origin.y - toast.frame.height / 2)
        toast.backgroundColor = UIColor(rgba: "#36454FE4")
        toast.alpha = 0
        toast.layer.cornerRadius = 15
        
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 100, height: 100)
        imageView.frame.origin = CGPoint(x: toast.frame.width / 2 - imageView.frame.width / 2, y: 10)
        imageView.image = image
        
        let label = UILabel()
        label.frame.size = CGSize(width: toast.frame.width - 20, height: 40)
        label.frame.origin = CGPoint(x: toast.frame.width / 2 - label.frame.width / 2, y: imageView.frame.height + 15)
        label.text = message
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        
        toast.addSubview(imageView)
        toast.addSubview(label)
        self.addSubview(toast)
        
        UIView.animate(withDuration: 0.2, animations: {
            toast.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 2, animations: {
                toast.alpha = 0.0
            }, completion: { _ in
                toast.removeFromSuperview()
            })
        })
    }
    
    func makeTokoDefaultToast(_ msg: String, type: ToastType = .positive, duration: TimeInterval = 5) {
        let toast = UILabel()
        let sideMargin = CGFloat(32)
        let topBotPadding = CGFloat(20)
        let bottomPadding = CGFloat(112)
        toast.text = msg
        toast.sizeToFit()
        toast.frame.size = CGSize(width: self.width - sideMargin, height: toast.frame.height + topBotPadding)
        toast.frame.origin = CGPoint(x: self.width / 2 - toast.width / 2, y: self.height - bottomPadding)
        
        //Style
        toast.backgroundColor = type == .positive ? UIColor.blue : UIColor.systemRed
        toast.borderColor = type == .positive ? UIColor.systemBlue : UIColor.systemRed
        toast.textColor = UIColor.black
        toast.borderWidth = 1
        toast.cornerRadius = 8
        toast.numberOfLines = 2
        toast.alpha = 0
        toast.font = UIFont.systemFont(ofSize: 12)
        toast.textAlignment = .center
        
        self.addSubview(toast)
        
        UIView.animate(withDuration: 0.2, animations: {
            toast.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: duration, animations: {
                toast.alpha = 0.0
            }, completion: { _ in
                toast.removeFromSuperview()
            })
        })
    }
}
