//
//  HomeViewModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

class HomeViewModel: BaseViewModel {
    private let dataSource: HomeDataSource
    var movieListResponseModel: MovieListModel?
    var movieListModel = [MovieListModel.Datum?]()
    var page = 1
    
    init(dataSource: HomeDataSource) {
        self.dataSource = dataSource
    }
    
    func checkLoadMore() {
        if page < (movieListResponseModel?.total_pages ?? 0) {
            page = page + 1
            loadMovies()
        }
    }
    
    func getDataCount() -> Int {
        return movieListModel.count
    }
    
    func loadMovies() {
        state.accept(.loading)
        let request = MovieListRequest(page: page)
        dataSource.getMovies(request: request)
            .subscribe(onNext: { [weak self] responseModel in
                self?.movieListResponseModel = responseModel
                if self?.page == 1 {
                    self?.movieListModel = responseModel?.results ?? []
                } else {
                    self?.movieListModel += responseModel?.results ?? []
                }
                self?.state.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func searchMovie(_ title: String?) {
        state.accept(.loading)
        let request = MovieListRequest(title: title)
        dataSource.searchMovies(request: request)
            .subscribe(onNext: { [weak self] responseModel in
                self?.movieListResponseModel = responseModel
                self?.movieListModel = responseModel?.results ?? []
                self?.state.accept(.finished)
            }, onError: { [weak self] error in
                self?.handleNetworkError(error)
                self?.state.accept(.failed)
            })
            .disposed(by: disposeBag)

        
    }
}
