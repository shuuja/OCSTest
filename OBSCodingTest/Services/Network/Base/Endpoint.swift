//
//  Endpoint.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import Foundation

/// An enumeration of HTTP methods.
enum HTTPMethod: String {

    case get,
         post,
         put,
         update,
         delete
}

/// An enumeration of HTTP content types.
enum HTTPContentType {

    case form
}

/// A typealias for HTTP parameters.
typealias HTTPParameters = [String: String]

/// A protocol defining an API endpoint.
protocol Endpoint {

    /// The base URL of the endpoint.
    var baseUrl: String { get }

    /// The path component of the endpoint URL.
    var path: String { get }

    /// The query parameters of the endpoint URL.
    var query: HTTPParameters { get }

    /// The HTTP body parameters of the endpoint.
    var body: HTTPParameters { get }

    /// The HTTP method used by the endpoint.
    var method: HTTPMethod { get }

    /// The content type of the HTTP body used by the endpoint.
    var contentType: HTTPContentType { get }
}

extension Endpoint {

    /// The default base URL for endpoints.
    var baseUrl: String {
        "https://ocs-test-backend.onrender.com/"
    }

    /// The default query parameters for endpoints.
    var query: HTTPParameters {
        HTTPParameters()
    }

    /// The default HTTP body parameters for endpoints.
    var body: HTTPParameters {
        HTTPParameters()
    }
}

