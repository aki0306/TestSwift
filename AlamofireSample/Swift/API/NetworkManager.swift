//
//  NetworkManager.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/03.
//

import Alamofire

// Shift-JIS でエンコードされたリクエストボディを送信するカスタムエンコーダー
struct ShiftJISEncoder: ParameterEncoder {
    // Encodable パラメータを Shift-JIS エンコーディングでリクエストにエンコード
    func encode<Parameters>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest where Parameters: Encodable {
        var request = request
        
        guard let parameters = parameters else {
            return request
        }
        
        // Encodable パラメータを JSON に変換
        let jsonData = try JSONEncoder().encode(parameters)
        
        // JSONデータを Shift-JIS エンコーディングされた文字列に変換
        if let jsonString = String(data: jsonData, encoding: .utf8),
           let shiftJISData = jsonString.data(using: .shiftJIS) {
            request.httpBody = shiftJISData
        } else {
            throw AFError.parameterEncoderFailed(reason: .encoderFailed(error: EncodingError.invalidValue(parameters, EncodingError.Context(codingPath: [], debugDescription: "Failed to encode parameters to Shift-JIS."))))
        }
        
        // Content-Type ヘッダーに Shift-JIS を指定
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json; charset=Shift_JIS", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
