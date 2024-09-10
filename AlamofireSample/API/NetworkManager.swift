//
//  NetworkManager.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/03.
//

import Alamofire

// リクエストに使用するデータモデル
struct MyRequestModel: Codable {
    let key1: String
    let key2: String
}

// レスポンスに使用するデータモデル
struct MyResponseModel: Codable {
    let result: String
    let message: String
}

// Shift-JIS でエンコードするカスタムエンコーダー
struct ShiftJISParameterEncoder: ParameterEncoder {
    static let shared = ShiftJISParameterEncoder()

    func encode<Parameters: Encodable>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest {
        var request = request
        guard let parameters = parameters else { return request }

        // JSONEncoder を使って一旦エンコード
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(parameters)

        // JSONデータをUTF-8で文字列に変換し、それをShift-JISに変換
        if let jsonString = String(data: jsonData, encoding: .utf8),
           let shiftJISData = jsonString.data(using: .shiftJIS) {
            request.httpBody = shiftJISData
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}

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
                    completion(.failure(error))
                }
            }
    }
    
    // 共通のリクエスト関数
    func performShiftJISRequest<T: Codable, U: Codable>(
        url: String,
        method: HTTPMethod,
        requestBody: T?,
        customUserAgent: String,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        // カスタムエンコーダーを使ってリクエストを作成
        let encoder = ShiftJISParameterEncoder.shared

        // Alamofire リクエスト
        AF.request(url, method: method, parameters: requestBody, encoder: encoder, headers: [
            "User-Agent": customUserAgent  // カスタム User-Agent の付与
        ])
        .validate()
        .responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let decodedResponse):
                completion(.success(decodedResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
