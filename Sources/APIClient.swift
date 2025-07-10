//
//  APIClient.swift
//  ResendSwift
//
//  Created by Onnwen Cassitto on 06/07/25.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime
import OpenAPIURLSession

func getConfigureClient(apiKey: String) throws -> APIProtocol {
    try Client(
        serverURL: Servers.Server1.url(),
        transport: URLSessionTransport(),
        middlewares: [
            AuthenticationMiddleware(apiKey: apiKey),
        ]
    )
}

struct AuthenticationMiddleware: ClientMiddleware {
    var apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = "Bearer \(apiKey)"
        return try await next(request, body, baseURL)
    }
}
