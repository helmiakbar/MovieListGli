import Cuckoo
@testable import TestGLI

import RxSwift


 class MockMovieDetailDataSource: MovieDetailDataSource, Cuckoo.ProtocolMock {
    
     typealias MocksType = MovieDetailDataSource
    
     typealias Stubbing = __StubbingProxy_MovieDetailDataSource
     typealias Verification = __VerificationProxy_MovieDetailDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MovieDetailDataSource?

     func enableDefaultImplementation(_ stub: MovieDetailDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?> {
        
    return cuckoo_manager.call("getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(request: request))
        
    }
    
    
    
     func getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?> {
        
    return cuckoo_manager.call("getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieReview(request: request))
        
    }
    
    
    
     func getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?> {
        
    return cuckoo_manager.call("getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieVideo(request: request))
        
    }
    
    
    
     func getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?> {
        
    return cuckoo_manager.call("getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCredit(request: request))
        
    }
    

	 struct __StubbingProxy_MovieDetailDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovieDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetailRequest), Observable<MovieDetailResponseModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieReview<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetailRequest), Observable<MovieReviewModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieVideo<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetailRequest), Observable<MovieVideoResponModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?>", parameterMatchers: matchers))
	    }
	    
	    func getMovieCredit<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetailRequest), Observable<MovieCreditResponseModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovieDetailDataSource.self, method: "getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MovieDetailDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieDetailRequest), Observable<MovieDetailResponseModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReview<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieDetailRequest), Observable<MovieReviewModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieVideo<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieDetailRequest), Observable<MovieVideoResponModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCredit<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieDetailRequest), Observable<MovieCreditResponseModel?>> where M1.MatchedType == MovieDetailRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetailRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MovieDetailDataSourceStub: MovieDetailDataSource {
    

    

    
    
    
     func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieDetailResponseModel?>).self)
    }
    
    
    
     func getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieReviewModel?>).self)
    }
    
    
    
     func getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieVideoResponModel?>).self)
    }
    
    
    
     func getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieCreditResponseModel?>).self)
    }
    
}


import Cuckoo
@testable import TestGLI

import RxSwift


 class MockHomeDataSource: HomeDataSource, Cuckoo.ProtocolMock {
    
     typealias MocksType = HomeDataSource
    
     typealias Stubbing = __StubbingProxy_HomeDataSource
     typealias Verification = __VerificationProxy_HomeDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HomeDataSource?

     func enableDefaultImplementation(_ stub: HomeDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getMovies(request: MovieListRequest) -> Observable<MovieListModel?> {
        
    return cuckoo_manager.call("getMovies(request: MovieListRequest) -> Observable<MovieListModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovies(request: request))
        
    }
    
    
    
     func searchMovies(request: MovieListRequest) -> Observable<MovieListModel?> {
        
    return cuckoo_manager.call("searchMovies(request: MovieListRequest) -> Observable<MovieListModel?>",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.searchMovies(request: request))
        
    }
    

	 struct __StubbingProxy_HomeDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovies<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieListRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieListRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieListRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeDataSource.self, method: "getMovies(request: MovieListRequest) -> Observable<MovieListModel?>", parameterMatchers: matchers))
	    }
	    
	    func searchMovies<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MovieListRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieListRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieListRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeDataSource.self, method: "searchMovies(request: MovieListRequest) -> Observable<MovieListModel?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HomeDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovies<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieListRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieListRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieListRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("getMovies(request: MovieListRequest) -> Observable<MovieListModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func searchMovies<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MovieListRequest), Observable<MovieListModel?>> where M1.MatchedType == MovieListRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieListRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("searchMovies(request: MovieListRequest) -> Observable<MovieListModel?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HomeDataSourceStub: HomeDataSource {
    

    

    
    
    
     func getMovies(request: MovieListRequest) -> Observable<MovieListModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieListModel?>).self)
    }
    
    
    
     func searchMovies(request: MovieListRequest) -> Observable<MovieListModel?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<MovieListModel?>).self)
    }
    
}

