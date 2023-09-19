//
//  AuthViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit
import WebKit

final class AuthViewController: VKBaseController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlComponents = URLComponents(string: "\(ApiData.authUrlString)\(ApiData.authEndpoint)")
        guard var urlComponents else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "51749293"),
            URLQueryItem(name: "redirect_uri", value: ApiData.blankUrlString),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
        ]

        guard let url = urlComponents.url else { return }

        let request = URLRequest(url: url)
        webView.load(request)
    }

}

extension AuthViewController {
    override func addSubviews() {
        super.addSubviews()

        view.setupView(webView)

    }
    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension AuthViewController: WKNavigationDelegate {


    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == ApiData.blankHtml,
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        let token = params["access_token"]
        let userID = params["user_id"]
        guard let token,
              let userID else { return }
        ApiData.token = token
        ApiData.userID = userID
        decisionHandler(.cancel)
        webView.removeFromSuperview()

        navigationController?.pushViewController(TabBarController(), animated: true)

        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first else { return }

        firstWindow.rootViewController = TabBarController()
    }
}
