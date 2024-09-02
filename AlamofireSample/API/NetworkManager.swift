//
//  NetworkManager.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/03.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    // Codableを使ったリクエストメソッド
    func request<T: Codable>(url: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             headers: HTTPHeaders? = nil,
                             customUserAgent: String? = nil,
                             completion: @escaping (Result<T, AFError>) -> Void) {
        var requestHeaders = headers ?? HTTPHeaders()
        
        // カスタムUser-Agentが指定されている場合、それを追加
        if let userAgent = customUserAgent {
            requestHeaders.add(name: "User-Agent", value: userAgent)
        }

        AF.request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: requestHeaders)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    self.handleError(error, completion: completion)
                }
            }
    }
    // 共通のエラーハンドリングメソッド
    private func handleError<T>(_ error: AFError, completion: @escaping (Result<T, AFError>) -> Void) {
        // エラーメッセージやステータスコードに基づいて処理を行う
        if let statusCode = error.responseCode {
            switch statusCode {
            case 400:
                print("Bad Request - サーバーがリクエストを理解できませんでした。")
            case 401:
                print("Unauthorized - 認証が必要です。")
            case 403:
                print("Forbidden - リクエストが拒否されました。")
            case 404:
                print("Not Found - リソースが見つかりません。")
            case 500:
                print("Internal Server Error - サーバーに問題があります。")
            default:
                print("Unhandled Error - ステータスコード: \(statusCode)")
            }
        } else {
            print("Network or Parsing Error - \(error.localizedDescription)")
        }
        
        // エラーをそのまま返す
        completion(.failure(error))
    }
}
