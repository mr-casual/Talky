//
//  RequestError.swift
// Talky
//
//  Created by Martin Klöpfel on 02.01.18.
//  Copyright © 2018 Martin Klöpfel. All rights reserved.
//

import Foundation


enum RequestError<ResponseBody>: Error {

    //MARK: case definitions
    case urlError(URLError)
    case apiError(HTTPURLResponse, ResponseBody)
    case decodingError(DecodingError)
    case encodingError(EncodingError)
    case unknowError(Error) // ???: do we need this?
}

