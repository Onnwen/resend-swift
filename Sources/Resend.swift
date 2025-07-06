//
//  Resend.swift
//  resend-swift
//
//  Created by Onnwen Cassitto on 06/07/25.
//

import Foundation
import OpenAPIRuntime

public final class Resend {
    private var apiKey: String
    private var client: APIProtocol
    
    public init(apiKey: String) throws {
        self.apiKey = apiKey
        self.client = try getConfigureClient(apiKey: apiKey)
    }
    
    @discardableResult
    public func sendEmail(_ body: Components.Schemas.SendEmailRequest, idempotencyKey: UUID = UUID()) async throws -> String? {
        let response = try await client.sendEmail(
            .init(
                headers: .init(
                    Idempotency_hyphen_Key: idempotencyKey.uuidString,
                ),
                body: .json(
                    body
                )
            )
        )
        
        switch response {
        case let .ok(body):
            return try body.body.json.id
        case let .undocumented(statusCode: statusCode, _):
            throw ResendError.status(statusCode)
        }
    }
    
    public func cancelEmail(_ id: String) async throws {
        let response = try await client.cancelEmail(
            path: .init(email_id: id)
        )
        
        switch response {
        case .ok:
            return
        case let .undocumented(statusCode: statusCode, _):
            throw ResendError.status(statusCode)
        }
    }
    
    enum ResendError: Error {
        case unknown
        case status(Int)
    }
}
