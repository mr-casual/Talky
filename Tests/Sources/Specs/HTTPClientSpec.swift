//
//  HTTPClientSpec.swift
//  TalkyTests
//
//  Created by Martin Klöpfel on 01.08.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Quick
import Nimble

@testable import Talky


fileprivate struct Test: Codable, Equatable {
    let testString: String
}

fileprivate let testApiBaseURL = URL(string: "https://api.test.com")!
fileprivate let testURL = URL(string: "Test", relativeTo: testApiBaseURL)!
fileprivate let errorURL = URL(string: "Error", relativeTo: testApiBaseURL)!

fileprivate let testParameter = Test(testString: "TestParameter")
fileprivate let testBody = Test(testString: "TestBody")
fileprivate let testError = Test(testString: "Error")


class HTTPClientSpec: QuickSpec {
    
    private let sessionMock: URLSessionMock = {
        let mock = URLSessionMock()
        let requestBuilder = RequestBuilder()
        // setup success results for test url
        // GET
        mock.setResult(result: ((try! JSONEncoder().encode(testBody),
                                 HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: testURL, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // POST
        mock.setResult(result: ((try! JSONEncoder().encode(testBody),
                                 HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: testURL, method: .post, body: testParameter, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // PUT
        mock.setResult(result: ((try! JSONEncoder().encode(testBody),
                                 HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: testURL, method: .put, body: testParameter, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // DELETE
        mock.setResult(result: ((try! JSONEncoder().encode(testBody),
                                 HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: testURL, method: .delete, headerFields: [.accept: "application/json;charset=UTF-8"]))
        
        // setup error results for test url
        // GET
        mock.setResult(result: ((try! JSONEncoder().encode(testError),
                                 HTTPURLResponse(url: errorURL, statusCode: 404, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: errorURL, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // POST
        mock.setResult(result: ((try! JSONEncoder().encode(testError),
                                 HTTPURLResponse(url: errorURL, statusCode: 400, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: errorURL, method: .post, body: testParameter, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // PUT
        mock.setResult(result: ((try! JSONEncoder().encode(testError),
                                 HTTPURLResponse(url: errorURL, statusCode: 400, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: errorURL, method: .put, body: testParameter, headerFields: [.accept: "application/json;charset=UTF-8"]))
        // DELETE
        mock.setResult(result: ((try! JSONEncoder().encode(testError),
                                 HTTPURLResponse(url: errorURL, statusCode: 404, httpVersion: nil, headerFields: nil), nil)),
                       for: try! requestBuilder.buildURLRequest(url: errorURL, method: .delete, headerFields: [.accept: "application/json;charset=UTF-8"]))
        return mock
    }()
    
    private lazy var  httpClient: HTTPClient = {
        let httpClient = HTTPClient(session: sessionMock)
        return httpClient
    }()
    
    override func spec() {
        
        describe("HTTPClient") {
            
            ///////////////////////////////////////////////////////////////
            //MARK: - success cases
            ///////////////////////////////////////////////////////////////
            
            context("When I run a GET request on \"\(testURL.absoluteString)\".") {
                it("should succeed and respond with \(testBody).") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.GET(url: testURL, completionWithOptinalResults: { (_, body: Test?, _: RequestError<AnyDecodable>?) in
                            expect(body) == testBody
                            done()
                        })
                    }
                }
            }
            
            context("When I run a POST request on \"\(testURL.absoluteString)\" with \"\(testParameter)\" as body.") {
                it("should succeed and respond with \(testBody).") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.POST(url: testURL, parameters: testParameter, completionWithOptinalResults: { (_, body: Test?, _: RequestError<AnyDecodable>?) in
                            expect(body) == testBody
                            done()
                        })
                    }
                }
            }

            context("When I run a PUT request on \"\(testURL.absoluteString)\" with \"\(testParameter)\" as body.") {
                it("should succeed and respond with \(testBody).") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.PUT(url: testURL, parameters: testParameter, completionWithOptinalResults: { (_, body: Test?, _: RequestError<AnyDecodable>?) in
                            expect(body) == testBody
                            done()
                        })
                    }
                }
            }

            context("When I run a DELETE request on \"\(testURL.absoluteString)\".") {
                it("should succeed and respond with \(testBody).") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.DELETE(url: testURL, completionWithOptinalResults: { (_, body: Test?, _: RequestError<AnyDecodable>?) in
                            expect(body) == testBody
                            done()
                        })
                    }
                }
            }
            
            ///////////////////////////////////////////////////////////////
            //MARK: - error cases
            ///////////////////////////////////////////////////////////////
            
            context("When I run a GET request on \"\(errorURL.absoluteString)\".") {
                it("should fail with status code '404' and \(testError) response.") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.GET(url: errorURL, completionWithOptinalResults: { (_, _: AnyDecodable?, error: RequestError<Test>?) in
                            switch error {
                            case .some(.apiError(let urlResponse, let errorBody)):
                                expect(urlResponse.statusCode) == 404
                                expect(errorBody) == testError
                            default:
                                fail("") // TODO: nice error message
                            }
                            done()
                        })
                    }
                }
            }
            
            context("When I run a POST request on \"\(errorURL.absoluteString)\" with \"\(testParameter)\" as body.") {
                it("should fail with status code '400' and \(testError) response.") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.POST(url: errorURL, parameters: testParameter, completionWithOptinalResults: { (_, _: AnyDecodable?, error: RequestError<Test>?) in
                            switch error {
                            case .some(.apiError(let urlResponse, let errorBody)):
                                expect(urlResponse.statusCode) == 400
                                expect(errorBody) == testError
                            default:
                                fail("") // TODO: nice error message
                            }
                            done()
                        })
                    }
                }
            }
            
            context("When I run a PUT request on \"\(errorURL.absoluteString)\" with \"\(testParameter)\" as body.") {
                it("should fail with status code '400' and \(testError) response.") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.PUT(url: errorURL, parameters: testParameter, completionWithOptinalResults: { (_, _: AnyDecodable?, error: RequestError<Test>?) in
                            switch error {
                            case .some(.apiError(let urlResponse, let errorBody)):
                                expect(urlResponse.statusCode) == 400
                                expect(errorBody) == testError
                            default:
                                fail("") // TODO: nice error message
                            }
                            done()
                        })
                    }
                }
            }
            
            context("When I run a DELETE request on \"\(errorURL.absoluteString)\".") {
                it("should fail with status code '404' and \(testError) response.") {
                    waitUntil(timeout: 10) { done in
                        
                        self.httpClient.DELETE(url: errorURL, completionWithOptinalResults: { (_, _: AnyDecodable?, error: RequestError<Test>?) in
                            switch error {
                            case .some(.apiError(let urlResponse, let errorBody)):
                                expect(urlResponse.statusCode) == 404
                                expect(errorBody) == testError
                            default:
                                fail("") // TODO: nice error message
                            }
                            done()
                        })
                    }
                }
            }
            
            
            ///////////////////////////////////////////////////////////////
            //MARK: -
            ///////////////////////////////////////////////////////////////
        }
    }
}


extension HTTPClient { //TODO: move it, move it ...
    
    public func GET<ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                       headerFields: [HTTPHeaderField : String]? = nil,
                                                                       completionWithOptinalResults: @escaping ((HTTPURLResponse?, ResponseBody?, RequestError<ErrorResponse>?) -> Void)) {
        self.GET(url: url, headerFields: headerFields) { (result: RequestResult<ResponseBody, ErrorResponse>) in
            switch result {
            case let .success(response, body):
                completionWithOptinalResults(response, body, nil)
            case .failure(let error):
                completionWithOptinalResults(nil, nil, error)
            }
        }
    }
    
    public func POST<Parameters: Encodable, ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                                               parameters: Parameters? = nil,
                                                                                               headerFields: [HTTPHeaderField : String]? = nil,
                                                                       completionWithOptinalResults: @escaping ((HTTPURLResponse?, ResponseBody?, RequestError<ErrorResponse>?) -> Void)) {
        self.POST(url: url, parameters: parameters, headerFields: headerFields) { (result: RequestResult<ResponseBody, ErrorResponse>) in
            switch result {
            case let .success(response, body):
                completionWithOptinalResults(response, body, nil)
            case .failure(let error):
                completionWithOptinalResults(nil, nil, error)
            }
        }
    }
    
    public func PUT<Parameters: Encodable, ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                                              parameters: Parameters? = nil,
                                                                                              headerFields: [HTTPHeaderField : String]? = nil,
                                                                       completionWithOptinalResults: @escaping ((HTTPURLResponse?, ResponseBody?, RequestError<ErrorResponse>?) -> Void)) {
        self.PUT(url: url, parameters: parameters, headerFields: headerFields) { (result: RequestResult<ResponseBody, ErrorResponse>) in
            switch result {
            case let .success(response, body):
                completionWithOptinalResults(response, body, nil)
            case .failure(let error):
                completionWithOptinalResults(nil, nil, error)
            }
        }
    }
    
    public func DELETE<ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                          headerFields: [HTTPHeaderField : String]? = nil,
                                                                       completionWithOptinalResults: @escaping ((HTTPURLResponse?, ResponseBody?, RequestError<ErrorResponse>?) -> Void)) {
        self.DELETE(url: url, headerFields: headerFields) { (result: RequestResult<ResponseBody, ErrorResponse>) in
            switch result {
            case let .success(response, body):
                completionWithOptinalResults(response, body, nil)
            case .failure(let error):
                completionWithOptinalResults(nil, nil, error)
            }
        }
    }
}
