//
//  ReviewListViewController.swift
//  TestGLI
//
//  Created by SehatQ on 12/02/23.
//

import UIKit
import FloatingPanel

class ReviewListViewController: BaseViewController {
    @IBOutlet weak var reviewTableView: UITableView!
    
    var viewModel = ReviewListViewModel()
    private var readMoreArticleFPC: FloatingPanelController?
    
    init() {
        super.init(nibName: String(describing: ReviewListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.reloadData()
        
        let nibToRegister = UINib(nibName: "ReviewListTableViewCell", bundle: nil)
        reviewTableView.register(nibToRegister, forCellReuseIdentifier: "ReviewListTableViewCell")
    }
    
    private func openFPC(dataReview: MovieReviewModel.Review?) {
        readMoreArticleFPC = FloatingPanelControllerHelper.createFloatingPanelController()
        readMoreArticleFPC?.delegate = self
        
        guard let fpc = readMoreArticleFPC else {
            return
        }
        
        let reviewVC = MoreReviewDetailViewController.loadFromNib()
        reviewVC.data = dataReview
        
        fpc.set(contentViewController: reviewVC)
        present(fpc, animated: true, completion: nil)
    }
}

extension ReviewListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewListTableViewCell") as? ReviewListTableViewCell {
            cell.setupData(data: viewModel.movieReviewModel?.results?[indexPath.row], index: indexPath.row)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ReviewListViewController: ReviewListTableCellDelegate {
    func didTapMore(index: Int) {
        openFPC(dataReview: viewModel.movieReviewModel?.results?[index])
    }
}

extension ReviewListViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return CustomPanelFullLayout()
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        if fpc.isAttracting == false {
            let loc = fpc.surfaceLocation
            let minY = fpc.surfaceLocation(for: .full).y - 6.0
            let maxY = fpc.surfaceLocation(for: .tip).y + 6.0
            fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
}
