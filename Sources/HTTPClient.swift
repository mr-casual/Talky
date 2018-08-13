//
// HTTPClient.swift
// Talky
//
//  Created by Martin Klöpfel on 20.09.17.
//  Copyright © 2017 Martin Klöpfel. All rights reserved.
//

import Foundation

/**
 */
protocol DecodingService {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: DecodingService {}

/**
 */
enum RequestResult<ResponseBody, ErrorResponse> {
    case success(HTTPURLResponse, ResponseBody)
    case failure(RequestError<ErrorResponse>)
}

/**
 */
protocol RequestRetrier {
    func shouldRetryRequest(_ request: URLRequest, response: HTTPURLResponse) -> Bool
}

/**
 */
protocol RequestModifier {
    func modifiyRequest(_ request: URLRequest)
}

/**
 */
class HTTPClient {
    
    // MARK: - Public properties
    lazy var requestBuilder = RequestBuilder()
    lazy var responseDecoder: DecodingService = JSONDecoder()
    
    
    // MARK: - Initializer(s)
    required init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    
    // MARK: - Public methods
    // MARK: - GET
    public func GET(url: URL,
                    headerFields: [HTTPHeaderField : String]? = nil,
                    completion: @escaping ((RequestResult<Data, Data>) -> Void)) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .get, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func GET(url: URL,
                    headerFields: [HTTPHeaderField : String]? = nil,
                    completion: @escaping ((RequestResult<Any, Any>) -> Void)) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .get, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func GET<ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                       headerFields: [HTTPHeaderField : String]? = nil,
                                                                       completion: @escaping ((RequestResult<ResponseBody, ErrorResponse>) -> Void)) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .get, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    
    // MARK: - POST
    public func POST<Parameters: Encodable>(url: URL,
                                            parameters: Parameters? = nil,
                                            headerFields: [HTTPHeaderField : String]? = nil,
                                            completion: @escaping (RequestResult<Data, Data>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .post, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func POST<Parameters: Encodable>(url: URL,
                                            parameters: Parameters? = nil,
                                            headerFields: [HTTPHeaderField : String]? = nil,
                                            completion: @escaping (RequestResult<Any, Any>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .post, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func POST<Parameters: Encodable, ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                                               parameters: Parameters? = nil,
                                                                                               headerFields: [HTTPHeaderField : String]? = nil,
                                                                                               completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .post, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }

    
    // MARK: - PUT
    public func PUT<Parameters: Encodable>(url: URL,
                                           parameters: Parameters? = nil,
                                           headerFields: [HTTPHeaderField : String]? = nil,
                                           completion: @escaping (RequestResult<Data, Data>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .post, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func PUT<Parameters: Encodable>(url: URL,
                                           parameters: Parameters? = nil,
                                           headerFields: [HTTPHeaderField : String]? = nil,
                                           completion: @escaping (RequestResult<Any, Any>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .post, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func PUT<Parameters: Encodable, ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                                              parameters: Parameters? = nil,
                                                                                              headerFields: [HTTPHeaderField : String]? = nil,
                                                                                              completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .put, body: parameters, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    
    // MARK: - DELETE
    public func DELETE(url: URL,
                       headerFields: [HTTPHeaderField : String]? = nil,
                       completion: @escaping ((RequestResult<Data, Data>) -> Void)) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .get, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func DELETE(url: URL,
                       headerFields: [HTTPHeaderField : String]? = nil,
                       completion: @escaping ((RequestResult<Any, Any>) -> Void)) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .get, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }
    
    public func DELETE<ResponseBody: Decodable, ErrorResponse: Decodable>(url: URL,
                                                                          headerFields: [HTTPHeaderField : String]? = nil,
                                                                          completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        var request: URLRequest
        do {
            request = try requestBuilder.buildURLRequest(url: url, method: .delete, headerFields: headerFields)
        }
        catch {
            handleError(error, completion: completion)
            return
        }
        
        perform(request: request, completion: completion)
    }

    
    // MARK: - URLRequest
    public func perform(request: URLRequest,
                        completion: @escaping ((RequestResult<Data, Data>) -> Void)) {
        
        currentDataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            
            switch (data, urlResponse, error) {
                
            case (.none, .none, .some(let error)): // an error occurred
                self.handleError(error, completion: completion)
            case (_, .some(let urlResponse as HTTPURLResponse), _): // successful request
                let body = data ?? Data()
                self.proceedResponse(urlResponse: urlResponse, body: body, completion: completion)
            default:
                fatalError("Unexpected Error") // actually this should never happen
            }
        }
        currentDataTask?.resume()
    }
    
    public func perform(request: URLRequest,
                        completion: @escaping ((RequestResult<Any, Any>) -> Void)) {
        perform(request: request) { (result: RequestResult<AnyDecodable, AnyDecodable>) in
            switch result {
            case let .success(response, body):
                completion(.success(response, body.value))
            case let .failure(error):
                switch error {
                case let .apiError(response, body):
                    self.handleError(RequestError.apiError(response, body), completion: completion)
                default:
                    self.handleError(error, completion: completion)
                }
            }
        }
    }
    
    public func perform<ResponseBody: Decodable, ErrorResponse: Decodable>(request: URLRequest,
                                                                           completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        var request = request
        if responseDecoder is JSONDecoder {
            request.setValue("application/json;charset=UTF-8", forHeaderField: .accept)
        }
        
        currentDataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            
            switch (data, urlResponse, error) {
                
            case (.none, .none, .some(let error)): // an error occurred
                self.handleError(error, completion: completion)
            case (_, .some(let urlResponse as HTTPURLResponse), _): // successful request
                let body = data ?? Data()
                self.proceedResponse(urlResponse: urlResponse, body: body, completion: completion)
            default:
                fatalError("Unexpected Error") // actually this should never happen
            }
        }
        currentDataTask?.resume()
    }
    
    // MARK: -
    // MARK: - Private properties
    private let session: URLSession
    private var currentDataTask: URLSessionDataTask? = nil
    
    private func proceedResponse<ResponseBody: Decodable, ErrorResponse: Decodable>(urlResponse: HTTPURLResponse,
                                                                                    body: Data,
                                                                                    completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        
        //        let debugResponse = try? JSONSerialization.jsonObject(with: body)
        //        print("response.data: \(debugResponse)")
        //        #if DEBUG
        //        if let url = urlResponse.url {
        //            print("success: \(url.absoluteString) %@", String(data: body, encoding: .utf8) ?? "")
        //        }
        //        #endif
        
        if validateResponse(urlResponse) {
            do {
                let responseBody = try responseDecoder.decode(ResponseBody.self, from: body)
                handleSuccess(response: urlResponse, body: responseBody, completion: completion)
            }
            catch(let error) {
                handleError(error, completion: completion)
                return
            }
        }
        else {
            do {
                let errorResponse = try responseDecoder.decode(ErrorResponse.self, from: body)
                handleError(RequestError.apiError(urlResponse, errorResponse), completion: completion)
            }
            catch(let error) {
                handleError(error, completion: completion)
                return
            }
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse) -> Bool {
        switch response.statusCode {
        case 200...300:
            return true
        default:
            return false
        }
    }
    
    //    private func proceedSuccess<ResponseBody, ErrorResponse>(urlResponse: HTTPURLResponse,
    //                                                             body: Data,
    //                                                             completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
    //        switch ResponseBody.self {
    //        case let type as Data.Type:
    //            handleSuccess(response: urlResponse, body: body as! ResponseBody, completion: completion)
    //        case let type as Decodable.Type:
    //            do {
    //                let responseBody = try self.responseDecoder.decode(ResponseBody as! Decodable, from: body)
    //
    //                if let anyDecodable = responseBody {
    //
    //                }
    //
    //                self.handleSuccess(response: urlResponse, body: responseBody, completion: completion)
    //            }
    //            catch(let error) {
    //                self.handleError(error, completion: completion)
    //                return
    //            }
    //        default:
    //            print("")
    //        }
    //    }
    
    private func handleError<ResponseBody, ErrorResponse>(_ error: Error,
                                                          completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        switch error {
        case let urlError as URLError:
            completion(.failure(.urlError(urlError)))
        case let requestError as RequestError<ErrorResponse>:
            completion(.failure(requestError))
        case let decodingError as DecodingError:
            completion(.failure(.decodingError(decodingError)))
        case let encodingError as EncodingError:
            completion(.failure(.encodingError(encodingError)))
        default:
            // I just want to know if this will happen sometimes
            // FIXME: remove this later
            fatalError("unknow error occurred")
            completion(.failure(.unknowError(error)))
        }
    }
    
    private func handleSuccess<ResponseBody, ErrorResponse>(response: HTTPURLResponse,
                                                            body: ResponseBody,
                                                            completion: @escaping (RequestResult<ResponseBody, ErrorResponse>) -> ()) {
        completion(.success(response, body))
    }
}

