//
//  ModelData.swift
//  AlamofireSample
//
//  Created by アキ on 2024/01/27.
//

struct ModelData: Codable {
    
    let data: [FoodTypes]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(data: [FoodTypes]) {
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([FoodTypes].self, forKey: .data)
    }
    
}

struct FoodTypes: Codable {
    let name: String
    let foodType: String
    var rate: Int

    enum CodingKeys: String, CodingKey {
        case name
        case foodType = "food_type"
        case rate
    }
    
    init(name: String, foodType: String, rate: Int) {
        self.name = name
        self.foodType = foodType
        self.rate = rate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.foodType = try container.decode(String.self, forKey: .foodType)
        self.rate = try container.decode(Int.self, forKey: .rate)
    }
}


