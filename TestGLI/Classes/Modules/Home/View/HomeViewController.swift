//
//  HomeViewController.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit
import SkeletonView

class HomeViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var retryBtn: UIButton!
    var viewModel = Dependency().resolve(HomeViewModel.self)
    
//    init() {
//        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        checkConnectivity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func checkConnectivity() {
        if Connectivity.isConnectedToInternet == true {
            noConnectionView.isHidden = true
            collectionView.isHidden = false
            setupView()
            bindViewModel()
        } else {
            noConnectionView.isHidden = false
            collectionView.isHidden = true
            showToastWithMessage(message: "Internet connection not available.", type: .negative, duration: 10)
        }
    }
    
    private func setupView() {
        searchTextField.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    private func setButton() {
        retryBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.checkConnectivity()
            }).disposed(by: disposeBag)
    }
    
    private func updateNextSet(){
        viewModel.checkLoadMore()
    }
    
    private func bindViewModel() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let weakSelf = self else { return }
                switch state {
                case .failed:
                    if weakSelf.viewModel.page == 1 {
                        weakSelf.collectionView.showAnimatedSkeleton()
                    }
                case .loading, .notLoad:
                    if weakSelf.viewModel.page == 1 {
                        weakSelf.collectionView.showAnimatedSkeleton()
                    }
                case .finished:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        weakSelf.collectionView.hideSkeleton()
                        weakSelf.collectionView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        viewModel.loadMovies()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if textField.text != "" {
            viewModel.page = 1
            viewModel.searchMovie(searchTextField.text ?? "")
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.page = 1
        if textField.text != "" {
            viewModel.searchMovie(searchTextField.text ?? "")
        } else {
            viewModel.loadMovies()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            cell.setData(data: viewModel.movieListModel[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel.movieListModel[indexPath.row] else { return }
        if let movieId = movie.id {
//            let movieDetailVC = Injection().resolve(MovieDetailViewController.self, args: movieId)
            let movieDetailVC = MovieDetailViewController(movieId: movieId)
            navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 168)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieListModel.count - 1 {
            updateNextSet()
        }
    }
}

extension HomeViewController: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: HomeCollectionViewCell.self)
    }
}
