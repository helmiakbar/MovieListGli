//
//  MovieMediaCollectionViewCell.swift
//  TestGLI
//
//  Created by SehatQ on 12/02/23.
//

import UIKit
import WebKit

class MovieMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerView: UIView!
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            webView.topAnchor.constraint(equalTo: playerView.topAnchor),
            webView.leftAnchor.constraint(equalTo: playerView.leftAnchor),
            webView.rightAnchor.constraint(equalTo: playerView.rightAnchor)
        ])
    }
    
    func loadURLString(_ urlString: String?) {
        if let webUrlString = urlString, let webURL = URL(string: webUrlString) {
            webView.load(URLRequest(url: webURL))
        }
    }
    
    func setupData(_ data: MovieVideoResponModel.videoDetail?) {
        if let validData = data, let validKey = validData.key {
            loadURLString("https://www.youtube.com/embed/\(validKey)")
        }
    }
}

extension MovieMediaCollectionViewCell: WKNavigationDelegate {
    
}
