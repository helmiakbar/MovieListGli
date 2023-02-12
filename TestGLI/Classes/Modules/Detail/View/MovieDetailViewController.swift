//
//  MovieDetailViewController.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit
import FloatingPanel
import SkeletonView

class MovieDetailViewController: BaseViewController {
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var reviewContentView: UIView!
    @IBOutlet weak var avatarReviewImageView: UIImageView!
    @IBOutlet weak var reviewWriteByLbl: UILabel!
    @IBOutlet weak var reviewDateLbl: UILabel!
    @IBOutlet weak var reviewTextLbl: UILabel!
    @IBOutlet weak var noReviewLbl: UILabel!
    @IBOutlet weak var allReviewBtn: UIButton!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var retryBtn: UIButton!
    
    var viewModel = Dependency().resolve(MovieDetailViewModel.self)
//    var viewModel = Injection().resolve(MovieDetailViewModel.self)
    var movieId = 0
    var genderNames = [String]()
    
    private var readMoreArticleFPC: FloatingPanelController?
    
    init(movieId: Int) {
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: nil)
        viewModel.request = MovieDetailRequest(movieId: movieId)
        self.movieId = movieId
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        checkConnectivity()
        setupButton()
    }
    
    private func checkConnectivity() {
        if Connectivity.isConnectedToInternet == true {
            errorView.isHidden = true
            stackView.isHidden = false
            bindViewModel()
        } else {
            errorView.isHidden = false
            stackView.isHidden = true
            showToastWithMessage(message: "Internet connection not available.", type: .negative, duration: 10)
        }
    }
    
    private func setupSkeloton() {
        [movieImageView, movieTitleLbl, genreLbl, descriptionLbl, castCollectionView, reviewContentView, avatarReviewImageView, reviewWriteByLbl, reviewDateLbl, reviewTextLbl, noReviewLbl, allReviewBtn, mediaCollectionView].forEach {
            $0?.showAnimatedSkeleton()
        }
    }
    
    private func hideSkeloton() {
        [movieImageView, movieTitleLbl, genreLbl, descriptionLbl, castCollectionView, reviewContentView, avatarReviewImageView, reviewWriteByLbl, reviewDateLbl, reviewTextLbl, noReviewLbl, allReviewBtn, mediaCollectionView].forEach {
            $0?.hideSkeleton()
        }
    }
    
    private func setupButton() {
        allReviewBtn.layer.cornerRadius = 8
        allReviewBtn.layer.borderWidth = 1
        allReviewBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        allReviewBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                let reviewListVC = ReviewListViewController()
                reviewListVC.viewModel.movieReviewModel = weakSelf.viewModel.movieReviewModel
                weakSelf.navigationController?.pushViewController(reviewListVC, animated: true)
            }).disposed(by: disposeBag)
        
        retryBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.checkConnectivity()
            }).disposed(by: disposeBag)
    }
    
    private func dropShadow() {
        reviewContentView.layer.cornerRadius = 8
        let grayColor = UIColor.init(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        reviewContentView.layer.borderColor = grayColor.cgColor
        reviewContentView.layer.applySketchShadow(color: grayColor, alpha: 1.0, x: 0, y: 1, blur: 4, spread: 0)
    }
    
    private func setupView() {
        noReviewLbl.text = "no reviews\nfor this movie"
        if let validMovieDetail = viewModel.movieDetailModel {
            let url = Constants.imageHost + (validMovieDetail.poster_path ?? "")
            movieImageView.loadImage(url: URL(string: url))
            var validDateString = ""
            if let validReleaseDate = validMovieDetail.release_date, let validDate = CustomDateFormatter.yyyy_dash_MM_dash_dd.dateFromString(validReleaseDate) {
                validDateString = CustomDateFormatter.yyyy.stringFromDate(validDate)
            }
            movieTitleLbl.text = "\(validMovieDetail.title ?? "") (\(validDateString))"
            
            if let genres = validMovieDetail.genres {
                for genre in genres {
                    if let name = genre.name {
                        genderNames.append(name)
                    }
                }
            }
            genreLbl.text = genderNames.joined(separator: ", ")
            descriptionLbl.text = "Overview:\n\(validMovieDetail.overview ?? "")"
        }
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
        castCollectionView.reloadData()
        
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        mediaCollectionView.register(UINib(nibName: "MovieMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieMediaCollectionViewCell")
        mediaCollectionView.reloadData()
        
        dropShadow()
        if viewModel.movieReviewModel?.results?.count ?? 0 > 1 {
            allReviewBtn.isHidden = false
            reviewContentView.isHidden = false
            noReviewLbl.isHidden = true
        } else {
            allReviewBtn.isHidden = true
            reviewContentView.isHidden = true
            noReviewLbl.isHidden = false
        }
        
        if let validReview = viewModel.movieReviewModel, let validResult = validReview.results?.last {
            var url = ""
            if (validResult.author_details?.avatar_path ?? "").contains("https://") {
                url = validReview.results?.last?.author_details?.avatar_path ?? ""
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
        readMoreArticleFPC = FloatingPanelControllerHelper.createFloatingPanelController()
        readMoreArticleFPC?.delegate = self
        
        guard let fpc = readMoreArticleFPC else {
            return
        }
        
        let reviewVC = MoreReviewDetailViewController.loadFromNib()
        if let validReview = viewModel.movieReviewModel, let validResult = validReview.results?.last {
            reviewVC.data = validResult
        }
        
        fpc.set(contentViewController: reviewVC)
        present(fpc, animated: true, completion: nil)
    }

    private func bindViewModel() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let weakSelf = self else { return }
                switch state {
                case .failed:
                    weakSelf.setupSkeloton()
                case .loading, .notLoad:
                    weakSelf.setupSkeloton()
                case .finished:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        weakSelf.hideSkeloton()
                        weakSelf.setupView()
                    }
                }
            }).disposed(by: disposeBag)
        viewModel.loadMovieDetail()
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mediaCollectionView{
            return viewModel.movieVideoModel?.results?.count ?? 0
        } else {
            return viewModel.movieCreditModel?.cast?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mediaCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieMediaCollectionViewCell", for: indexPath) as? MovieMediaCollectionViewCell {
                cell.setupData(viewModel.movieVideoModel?.results?[indexPath.row])
                return cell
            }
            
            return UICollectionViewCell()
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell {
                cell.setupData(data: viewModel.movieCreditModel?.cast?[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mediaCollectionView {
            return CGSize(width: mediaCollectionView.frame.width/2, height: mediaCollectionView.frame.height)
        } else {
            return CGSize(width: castCollectionView.frame.width/3, height: castCollectionView.frame.height)
        }
    }
}

extension MovieDetailViewController: FloatingPanelControllerDelegate {
    
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

extension MovieDetailViewController: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if skeletonView == castCollectionView {
            return String(describing: CastCollectionViewCell.self)
        } else {
            return String(describing: mediaCollectionView.self)
        }
    }
}
