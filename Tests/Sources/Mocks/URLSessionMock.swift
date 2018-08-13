//
//  URLSessionMock.swift
//  TalkyTests
//
//  Created by Martin Klöpfel on 01.08.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Foundation


typealias DataTaskResult = (Data?, URLResponse?, Error?)
typealias DataTaskCompletionHandler = (DataTaskResult) -> ()



class URLSessionMock: URLSession {
    
    private var results = [URLRequest: DataTaskResult]()
    
    func setResult(result: DataTaskResult, for request: URLRequest) {
        results[request] = result
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {

        return URLSessionDataTaskMock { [weak self] in
            
            guard let result = self?.results[request] else {
                fatalError("No data task result found. Please use 'setResult:request:' to setup a result for a given request.")
            }
            completionHandler(result)
        }
    }
}


fileprivate class URLSessionDataTaskMock: URLSessionDataTask {
    
    var onResume: (()->())? = nil
    
    init(onResume: @escaping (()->())) {
        self.onResume = onResume
    }
    
    override func resume() {
        onResume?()
    }
}
