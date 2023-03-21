//
//  HTTPClient.swift
//

import Foundation


protocol HTTPClient {
    var configuration: APIConfigurable { get set }
    var reachability: ReachabilityCheckable { get set }
    func sendRequest<T: Decodable>(endpoint: Router, responseModel: T.Type) async throws -> T
}

final class DefaultHTTPClient: HTTPClient {
    var configuration: APIConfigurable
    var reachability: ReachabilityCheckable

    init(reachability: ReachabilityCheckable, configuration: APIConfigurable) {
        self.reachability = reachability
        self.configuration = configuration
    }
}

extension HTTPClient {
    public func sendRequest<T: Decodable>(
        endpoint: Router,
        responseModel: T.Type
    ) async throws -> T {
        do {
            guard reachability.isOnline else { throw APIError.offline }
            guard let url = URL(string: "\(configuration.basePath)\(endpoint.path)") else {
                throw APIError.invalidURL
            }
            let mutableURLRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: mutableURLRequest)

            guard let response = response as? HTTPURLResponse else {
                throw APIError.noResponse
            }

            switch response.statusCode {
            case 200 ... 299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw APIError.decode
                }
                return decodedResponse
            default:
                throw APIError.unknown
            }
        } catch {
            throw error
        }
    }
}
