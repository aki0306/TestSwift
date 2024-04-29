//
//  UserDefaultExtension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/27.
//

import Foundation

private let testKey = "testKey"

extension UserDefaults {
    
    static var test: [String] {
        
        get {
            return standard.stringArray(forKey: testKey) ?? []
        }
        
        set(val){
            
            // 空の場合
            if val.isEmpty {
                return
            }
            
            var tests = standard.stringArray(forKey: testKey) ?? []
            
            // 重複した場合
            tests.removeAll(where: {
                $0 == val[0]
            })
            
            // 20件の場合
            if tests.count == 20 {
                tests.removeLast()
            }
            
            // 配列にデータを追加
            tests.insert(contentsOf: val, at: 0)
            
            standard.set(tests, forKey: testKey)
        }
    }
}
