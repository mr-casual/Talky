//
//  HTTPHeaderField.swift
// Talky
//
//  Created by Martin Klöpfel on 02.01.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Foundation


public enum HTTPHeaderField: RawRepresentable, Hashable {
    
    public typealias RawValue = String
    
    case accept
    case acceptCharset
    case acceptEncoding
    case acceptLanguage
    case authorization
    case cacheControl
    case connection
    case cookie
    case contentLength
    case contentMD5
    case contentType
    case date
    case expect
    case forwarded
    case from
    case host
    case ifMatch
    case ifModifiedSince
    case ifNoneMatch
    case ifRange
    case ifUnmodifiedSince
    case maxForwards
    case pragma
    case proxyAuthorization
    case range
    case referer
    case TE
    case transferEncoding
    case upgrade
    case userAgent
    case via
    case warning
    case xAPIKey
    case custom(key: String)
    
    
    public init(rawValue: String) {
        switch rawValue {
        case "Accept":
            self = .accept
        case "Accept-Charset":
            self = .acceptCharset
        case "Accept-Encoding":
            self = .acceptEncoding
        case "Accept-Language":
            self = .acceptLanguage
        case "Authorization":
            self = .authorization
        case "Cache-Control":
            self = .cacheControl
        case "Connection":
            self = .connection
        case "Cookie":
            self = .cookie
        case "Content-Length":
            self = .contentLength
        case "Content-MD5":
            self = .contentMD5
        case "Content-Type":
            self = .contentType
        case "Date":
            self = .date
        case "Expect":
            self = .expect
        case "Forwarded":
            self = .forwarded
        case "From":
            self = .from
        case "Host":
            self = .host
        case "If-Match":
            self = .ifMatch
        case "If-Modified-Since":
            self = .ifModifiedSince
        case "If-None-Match":
            self = .ifNoneMatch
        case "If-Range":
            self = .ifRange
        case "If-Unmodified-Since":
            self = .ifUnmodifiedSince
        case "Max-Forwards":
            self = .maxForwards
        case "Pragma":
            self = .pragma
        case "Proxy-Authorization":
            self = .proxyAuthorization
        case "Range":
            self = .range
        case "Referer":
            self = .referer
        case "TE":
            self = .TE
        case "Transfer-Encoding":
            self = .transferEncoding
        case "Upgrade":
            self = .upgrade
        case "User-Agent":
            self = .userAgent
        case "Via":
            self = .via
        case "Warning":
            self = .warning
            
        case "x-api-key":
            self = .xAPIKey
        default:
            self = .custom(key: rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .accept:
            return "Accept"
        case .acceptCharset:
            return "Accept-Charset"
        case .acceptEncoding:
            return "Accept-Encoding"
        case .acceptLanguage:
            return "Accept-Language"
        case .authorization:
            return "Authorization"
        case .cacheControl:
            return "Cache-Control"
        case .connection:
            return "Connection"
        case .cookie:
            return "Cookie"
        case .contentLength:
            return "Content-Length"
        case .contentMD5:
            return "Content-MD5"
        case .contentType:
            return "Content-Type"
        case .date:
            return "Date"
        case .expect:
            return "Expect"
        case .forwarded:
            return "Forwarded"
        case .from:
            return "From"
        case .host:
            return "Host"
        case .ifMatch:
            return "If-Match"
        case .ifModifiedSince:
            return "If-Modified-Since"
        case .ifNoneMatch:
            return "If-None-Match"
        case .ifRange:
            return "If-Range"
        case .ifUnmodifiedSince:
            return "If-Unmodified-Since"
        case .maxForwards:
            return "Max-Forwards"
        case .pragma:
            return "Pragma"
        case .proxyAuthorization:
            return "Proxy-Authorization"
        case .range:
            return "Range"
        case .referer:
            return "Referer"
        case .TE:
            return "TE"
        case .transferEncoding:
            return "Transfer-Encoding"
        case .upgrade:
            return "Upgrade"
        case .userAgent:
            return "User-Agent"
        case .via:
            return "Via"
        case .warning:
            return "Warning"
            
        case .xAPIKey:
            return "x-api-key"
        case .custom(let key):
            return key
        }
    }
}


extension URLRequest {
    
    public var headerFields: [HTTPHeaderField : String]? {
        return allHTTPHeaderFields?.reduce(into: [HTTPHeaderField : String](), { $0[HTTPHeaderField(rawValue: $1.key)] = $1.value })
    }
    
    public func value(forHeaderField field: HTTPHeaderField) -> String? {
        return value(forHTTPHeaderField: field.rawValue)
    }
    
    public mutating func setValue(_ value: String?, forHeaderField field: HTTPHeaderField) {
        setValue(value, forHTTPHeaderField: field.rawValue)
    }
    
    public mutating func addValue(_ value: String, forHeaderField field: HTTPHeaderField) {
        addValue(value, forHTTPHeaderField: field.rawValue)
    }
}
