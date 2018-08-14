//
//  HTTPMethod.swift
// Talky
//
//  Created by Martin Klöpfel on 02.01.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Foundation


public enum HTTPMethod: String, Equatable {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

public extension URLRequest {
    
    public var method: HTTPMethod? {
        get {
            if let rawValue = httpMethod {
                return HTTPMethod(rawValue: rawValue)
            }
            return nil
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }
}
