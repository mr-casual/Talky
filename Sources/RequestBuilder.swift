//
//  RequestBuilder.swift
//  Talky
//
//  Created by Martin Klöpfel on 01.08.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Foundation


public protocol EncodingService {
    func encode<T : Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: EncodingService { }


public class RequestBuilder {
        lazy var parameterEncoder: EncodingService = JSONEncoder()
    
    func buildURLRequest(url: URL, method: HTTPMethod = .get, headerFields: [HTTPHeaderField : String]? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headerFields?.forEach({ (field, value) in
            request.setValue(value, forHTTPHeaderField: field.rawValue)
        })
        return request
    }
    
    func buildURLRequest<Body: Encodable>(url: URL, method: HTTPMethod, body: Body?, headerFields: [HTTPHeaderField : String]? = nil) throws -> URLRequest {
        
        var request = try buildURLRequest(url: url, method: method, headerFields: headerFields)
        
        switch method {
        case .post,
             .put:
            if let body = body {
                request.httpBody = try parameterEncoder.encode(body)
                if parameterEncoder is JSONEncoder {
                    request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                }
            }
        default: break
        }
        return request
    }
}

//            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)! //???: resolvingAgainstBaseURL? WHAT?
//
//            if let parameters = parameters {
//                let jsonData = try parameterEncoder.encode(parameters)
//                //NOTE: works only if parameters are not nested...
//                if let parameterDictionary = try JSONSerialization.jsonObject(with: jsonData) as? [String: String] {
//                    urlComponents.queryItems = parameterDictionary.map { key, value in URLQueryItem(name: key, value: value) }
//                }
//            }
//            request = URLRequest(url: urlComponents.url!)

//private func buildURLRequest() throws -> URLRequest {
//    
//    var request: URLRequest
//    
//    switch method {
//    case .get:
//        
//        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)! //???: resolvingAgainstBaseURL? WHAT?
//        
//        if let parameters = parameters {
//            let jsonData = try parameterEncoder.encode(parameters)
//            //NOTE: works only if parameters are not nested...
//            if let parameterDictionary = try JSONSerialization.jsonObject(with: jsonData) as? [String: String] {
//                urlComponents.queryItems = parameterDictionary.map { key, value in URLQueryItem(name: key, value: value) }
//            }
//        }
//        request = URLRequest(url: urlComponents.url!)
//        
//    default:
//        request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        if let parameters = parameters {
//            request.httpBody = try parameterEncoder.encode(parameters)
//            setValue("application/json;charset=UTF-8", forHTTPHeaderField: .contentType)
//        }
//    }
//    
//    for (field, value) in headerFields {
//        request.setValue(value, forHTTPHeaderField: field.rawValue)
//    }
//    
//    return request
//}
