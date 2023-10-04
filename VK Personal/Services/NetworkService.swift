//
//  NetworkService.swift
//  VK Personal
//
//  Created by Олег Алексеев on 18.09.2023.
//

import Foundation
import OSLog

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
    case invalidPhotoUrl
}

struct Request<T: Decodable>: APIRequest {

    let logger = Logger(subsystem: "NetworkService", category: "Request struct")

    var endpoint: ApiData.Endpoints
    var methodType: ApiData.MethodType
    var quantity: Int?

    var urlRequest: URLRequest? {
        let urlComponents = URLComponents(string: "\(ApiData.baseUrlString)\(endpoint.rawValue)\(methodType.rawValue)")

        guard var urlComponents else { return nil }

        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: ApiData.token),
            URLQueryItem(name: "user_id", value: ApiData.userID),
            URLQueryItem(name: "v", value: "5.150"),
        ]

        if let quantity {
            urlComponents.queryItems?.append(URLQueryItem(name: "count", value: String(describing: quantity)))
        }

        switch endpoint {
        case .friends:
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "photo_200_orig,online"))
        case .groups:
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "description"))
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .photos:
            urlComponents.queryItems?.append(URLQueryItem(name: "album_id", value: "profile"))
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .account:
            urlComponents.queryItems?.remove(at: 1)
        }

        guard let url = urlComponents.url else {
            logger.error("url failure")
            return nil
        }
        return URLRequest(url: url)
    }

    func decodeResponse(data: Data) throws -> T {
        do {
            let request = try JSONDecoder().decode(ResponseWrapper<T>.self, from: data)
            return request.response
        } catch {
            logger.error("error with data parsing")
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
    let logger  = Logger(subsystem: "NetworkService", category: "NetworkService class")

    func sendRequest<Request: APIRequest>(_ request: Request, isArray: Bool = true) async throws -> Request.Response {
        guard let urlRequest = request.urlRequest else {
            logger.error("URL-request is invalid")
            throw APIRequestError.invalidURLRequest
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            logger.error("response failure")
            throw APIRequestError.itemNotFound
        }

        let decodedResponse = try request.decodeResponse(data: data)
        return decodedResponse
    }

    func getFriends(quantity: Int? = nil, _ completion: @escaping (Result<[Friend], Error>) -> Void) {
        Task {
            do {
                let request = Request<Response<Friend>>(endpoint: .friends, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request).items
                for (index, data) in fetchedData.enumerated() {
                    guard let url = data.photoUrl else {
                        logger.error("photoUrl failure")
                        completion(.failure(APIRequestError.invalidPhotoUrl))
                        return
                    }
                    let imageRequest = ImageAPIRequest(url: url)
                    let image = try await sendRequest(imageRequest)
                    fetchedData[index].photoData = image
                }
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }

    func getGroups(quantity: Int? = nil, _ completion: @escaping (Result<[Group], Error>) -> Void) {
        Task {
            do {
                let request = Request<Response<Group>>(endpoint: .groups, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request).items
                for (index, data) in fetchedData.enumerated() {
                    guard let url = data.photoUrl else {
                        completion(.failure(APIRequestError.invalidPhotoUrl))
                        return
                    }
                    let imageRequest = ImageAPIRequest(url: url)
                    let image = try await sendRequest(imageRequest)
                    fetchedData[index].photoData = image
                }
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }

    func getPhotos(quantity: Int? = nil, _ completion: @escaping ([Photo]) -> Void) {
        Task {
            do {
                let request = Request<Response<Photo>>(endpoint: .photos, methodType: .get, quantity: quantity)
                var fetchedData = try await sendRequest(request).items
                for (index, data) in fetchedData.enumerated() {
                    for (sizeIndex, sizeData) in data.sizes.enumerated() {
                        let imageRequest = ImageAPIRequest(url: sizeData.url)
                        let image = try await sendRequest(imageRequest)
                        fetchedData[index].sizes[sizeIndex].photoData = image
                    }
                }
                completion(fetchedData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getAccount(_ completion: @escaping (Result<Account, Error>) -> Void) {
        Task {
            do {
                let request = Request<Account>(endpoint: .account, methodType: .getProfileInfo)
                var fetchedData = try await sendRequest(request)
                guard let url = fetchedData.photoUrl else {
                    completion(.failure(APIRequestError.invalidPhotoUrl))
                    return
                }
                let imageRequest = ImageAPIRequest(url: url)
                let image = try await sendRequest(imageRequest)
                fetchedData.photoData = image
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
