//
//  NetworkProvider.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import RxSwift
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}

class NetworkProvider: NetworkProtocol {
    func get(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .get, urlString: url, bodyParams: bodyParams, header: header)
    }
   
    func post(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .post, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    func put(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .put, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    func delete(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .delete, urlString: url, bodyParams: bodyParams, header: header)
    }

    private func requestMethod(method: HTTPMethod, urlString: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return Observable<Data>.create { [weak self] observer in
            if Connectivity.isConnectedToInternet == false {
                observer.onError(NSError(domain: "", code: NSURLErrorNotConnectedToInternet, userInfo: nil))
            } else {
                guard let _ = self,
                      let url = URL(string: urlString) else {
                    return Disposables.create {}
                }
                                       
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("ios", forHTTPHeaderField: "Client-Id")
                            
                header.forEach { (key, value) in
                    urlRequest.setValue(key, forHTTPHeaderField: value)
                }
                                                        
                if !bodyParams.isEmpty,
                   let bodyData = try? JSONSerialization.data(withJSONObject: bodyParams, options: []) {
                    print("BODY: \(bodyParams))")
                    urlRequest.httpBody = bodyData
                }
                
                let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        observer.on(.error(error))
                    } else if let data = data {
                        print("HEADER: \(String(describing: urlRequest.allHTTPHeaderFields))")
                        
                        print("URL: \(urlString)")
                        
                        if let debugPrint = String(data: data, encoding: .utf8) {
                            print("RESPONSE: \(debugPrint)")
                        }
                        
                        let responseError = try? JSONDecoder().decode(ResponseErrorArrayModel.self, from: data)
                        let httpResponse = response as? HTTPURLResponse
                            
                        if var firstError = responseError?.errors?.first {
                            firstError.status = NSNumber(value: httpResponse?.statusCode ?? 0)
                            observer.on(.error(firstError))
                        } else if let singleError = responseError?.error {
                            let error = ResponseErrorModel(detail: singleError, status: NSNumber(value: httpResponse?.statusCode ?? 0))
                            observer.on(.error(error))
                        } else {
                            observer.on(.next(data))
                        }
                    }
                }
                
                task.resume()

                return Disposables.create {
                    task.cancel()
                }
            }
            return Disposables.create()
        }
    }

}

