import Foundation

// ジェネリックな型を使用した構造体
struct AnyDecodable: Decodable {
    
    let value: Any
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            value = string
        } else if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let nestedDictionary = try? container.decode([String: AnyDecodable].self) {
            // ネストされた辞書を再帰的に処理
            value = nestedDictionary.mapValues { $0.value }
        } else if let array = try? container.decode([AnyDecodable].self) {
            // 配列を再帰的に処理
            value = array.map { $0.value }
        } else {
            // 上記のいずれにも当てはまらない場合は空の値を設定
            value = ()
        }
    }
}
