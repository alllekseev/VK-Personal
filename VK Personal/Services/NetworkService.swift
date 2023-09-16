//
//  NetworkService.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

final class NetworkService {
    private let session = URLSession.shared

    func fetchFriends(quantity: Int) {
        let urlComponents = URLComponents(string: "\(ApiData.baseUrlString)\(ApiData.Endpoints.friends)\(ApiData.MethodType.get)")

        guard var urlComponents else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: ApiData.token),
            URLQueryItem(name: "user_id", value: ApiData.userID),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "\(quantity)"),
            URLQueryItem(name: "fields", value: "photo_50"),
        ]

        guard let url = urlComponents.url else { return }

        print("url: \(url)")

        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }

            do {
                let fetchedData = try JSONDecoder().decode(ResponseWrapper<Friend>.self,
                                                           from: data)
                print(fetchedData.response.items)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func fetchGroups(quantity: Int) {
        let urlComponents = URLComponents(string: "\(ApiData.baseUrlString)\(ApiData.Endpoints.groups)\(ApiData.MethodType.get)")

        guard var urlComponents else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: ApiData.token),
            URLQueryItem(name: "user_id", value: ApiData.userID),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "\(quantity)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "photo_50"),
        ]

        guard let url = urlComponents.url else { return }

        print("url: \(url)")

        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }

            do {
                let fetchedData = try JSONDecoder().decode(ResponseWrapper<Group>.self,
                                                           from: data)
                print(fetchedData.response.items)
//                data.prettyPrintedJSONString()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func fetchPhotos(quantity: Int) {
        let urlComponents = URLComponents(string: "\(ApiData.baseUrlString)\(ApiData.Endpoints.photos)\(ApiData.MethodType.get)")

        guard var urlComponents else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: ApiData.token),
            URLQueryItem(name: "user_id", value: ApiData.userID),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "extended", value: "1"),
        ]

        guard let url = urlComponents.url else { return }

        print("url: \(url)")

        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }

            do {
                let fetchedData = try JSONDecoder().decode(ResponseWrapper<Photo>.self,
                                                           from: data)
                print(fetchedData.response.items)
//                data.prettyPrintedJSONString()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
