//
//  NetworkService.swift
//  VK Personal
//
//  Created by Олег Алексеев on 18.09.2023.
//

import Foundation

protocol APIRequest {
    associatedtype Response

    var urlRequest: URLRequest? { get }

    func decodeResponse(data: Data) throws -> Response
}

enum APIRequestError: Error {
    case invalidURLRequest
    case invalidData
    case itemNotFound
    case imageNotFound
}

struct Request<T: Decodable>: APIRequest {

    var endpoint: ApiData.Endpoints
    var methodType: ApiData.MethodType
    var quantity: Int?

    var urlRequest: URLRequest? {
        let urlComponents = URLComponents(string: "\(ApiData.baseUrlString)\(endpoint.rawValue)\(methodType.rawValue)")

        guard var urlComponents else { return nil }

        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: ApiData.token),
            URLQueryItem(name: "user_id", value: ApiData.userID),
            URLQueryItem(name: "v", value: "5.131"),
        ]

        if let quantity {
            urlComponents.queryItems?.append(URLQueryItem(name: "count", value: String(describing: quantity)))
        }

        switch endpoint {
        case .friends:
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50,online"))
        case .groups:
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .photos:
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
            urlComponents.queryItems?.append(URLQueryItem(name: "album_id", value: "wall"))
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        }

        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }

    func decodeResponse(data: Data) throws -> [T] {
        do {
            let request = try JSONDecoder().decode(ResponseWrapper<T>.self, from: data)
            return request.response.items
        } catch {
            throw APIRequestError.invalidData
        }
    }
}

struct ImageAPIRequest: APIRequest {

    enum ResponseError: Error {
        case invalidImageData
    }

    var url: URL

    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }

    func decodeResponse(data: Data) throws -> Data {
        return data
    }
}

final class NetworkService {
    func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        guard let urlRequest = request.urlRequest else {
            throw APIRequestError.invalidURLRequest
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIRequestError.itemNotFound
        }

        let decodedResponse = try request.decodeResponse(data: data)
        return decodedResponse
    }

    func getFriends(quantity: Int? = nil, _ completion: @escaping ([Friend]) -> Void) {
        Task {
            do {
                let request = Request<Friend>(endpoint: .friends, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request)
                for (index, data) in fetchedData.enumerated() {
                    guard let url = data.photoUrl else { return }
                    let imageRequest = ImageAPIRequest(url: url)
                    let image = try await sendRequest(imageRequest)
                    fetchedData[index].photoData = image
                }
                completion(fetchedData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getGroups(quantity: Int? = nil, _ completion: @escaping ([Group]) -> Void) {
        Task {
            do {
                let request = Request<Group>(endpoint: .groups, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request)
                for (index, data) in fetchedData.enumerated() {
                    let imageRequest = ImageAPIRequest(url: data.photoUrl)
                    let image = try await sendRequest(imageRequest)
                    fetchedData[index].photoData = image
                }
                completion(fetchedData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getPhotos(quantity: Int? = nil, _ completion: @escaping ([Photo]) -> Void) {
        Task {
            do {
                let request = Request<Photo>(endpoint: .photos, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request)
                for (index, data) in fetchedData.enumerated() {
                    for (sizeIndex, sizeData) in data.sizes.enumerated() {
                        let imageRequest = ImageAPIRequest(url: sizeData.url)
                        let image = try await sendRequest(imageRequest)
                        fetchedData[index].sizes[sizeIndex].photoData = image
                    }
                }
                completion(fetchedData)
            } catch {
                print(error)
            }
        }
    }
}
