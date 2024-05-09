import Foundation

//// ジェネリックな型を使用した構造体
//struct AnyDecodable: Decodable {
//    
//    let value: Any
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        
//        if let string = try? container.decode(String.self) {
//            value = string
//        } else if let int = try? container.decode(Int.self) {
//            value = int
//        } else if let double = try? container.decode(Double.self) {
//            value = double
//        } else if let bool = try? container.decode(Bool.self) {
//            value = bool
//        } else if let nestedDictionary = try? container.decode([String: AnyDecodable].self) {
//            // ネストされた辞書を再帰的に処理
//            value = nestedDictionary.mapValues { $0.value }
//        } else if let array = try? container.decode([AnyDecodable].self) {
//            // 配列を再帰的に処理
//            value = array.map { $0.value }
//        } else {
//            // 上記のいずれにも当てはまらない場合は空の値を設定
//            value = ()
//        }
//    }
//}

import Foundation

// JSONデータのキーと値を表す構造体
struct JSONKeyValue {
    let key: String
    let value: Any
}

// ジェネリックな型を使用した構造体
struct AnyDecodable: Decodable {
    let values: [JSONKeyValue]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        var tempValues: [JSONKeyValue] = []
        
        for key in container.allKeys {
            let nestedDecoder = try container.superDecoder(forKey: key)
            let value = try AnyDecodable.decodeValue(from: nestedDecoder)
            tempValues.append(JSONKeyValue(key: key.stringValue, value: value))
        }
        
        self.values = tempValues
    }
    
    private static func decodeValue(from decoder: Decoder) throws -> Any {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            return string
        } else if let int = try? container.decode(Int.self) {
            return int
        } else if let double = try? container.decode(Double.self) {
            return double
        } else if let bool = try? container.decode(Bool.self) {
            return bool
        } else if let nestedDictionary = try? container.decode([String: AnyDecodable].self) {
            // ネストされた辞書を再帰的に処理
            return nestedDictionary.mapValues { $0.values }
        } else if let array = try? container.decode([AnyDecodable].self) {
            // 配列を再帰的に処理
            return array.map { $0.values }
        } else {
            // 上記のいずれにも当てはまらない場合は空の値を設定
            return ()
        }
    }
}

// キーがどのような型でも扱えるキー型
struct AnyCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}
