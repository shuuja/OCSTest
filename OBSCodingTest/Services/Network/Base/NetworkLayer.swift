//
//  NetworkLayer.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import Foundation

struct NetworkLayer {

    // MARK: - Error

    /// Error that can occur while working with the network layer.
    struct NetworkLayerError: LocalizedError {

        /// The error message to be displayed to the user.
        let message: String

        /// The error description to be displayed to the user.
        var errorDescription: String? {
            return message
        }

        /// The localized error description to be displayed to the user.
        var localizedDescription: String {
            return message
        }
    }

    // MARK: - Methods

    /// Fetches data from the specified endpoint and decodes it into the specified data model.
    /// - Parameters:
    ///   - endpoint: The endpoint to fetch data from.
    ///   - with: The data model to decode the fetched data into.
    /// - Returns: A result containing either the decoded data model or an error.
    static func fetch<D: Codable>(_ endpoint: Endpoint, with: D.Type) async throws -> (Result<D, NetworkLayerError>) {

        // Construct the URL from the endpoint.
        guard let url = URL(string: endpoint.baseUrl + endpoint.path) else {
            return .failure(NetworkLayerError.init(message: "Invalid URL"))
        }

        // Create the URL request.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Set the request's content type and fetch the data.
        switch endpoint.contentType {
        case .form:
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)

            // Attempt to decode the fetched data into the specified data model.
            guard let object = try? JSONDecoder().decode(with, from: data) else {
                return .failure(.init(message: "Could not parse data"))
            }

            // Return the decoded data model.
            return .success(object)
        }
    }
}

