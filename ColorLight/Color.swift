//
//  Color.swift
//  ColorLight
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import UIKit

extension Date {
    var meridiemValue: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
}

extension Double {
    var meridiemUnixTimestamp: String {
        return Date(timeIntervalSince1970: self).meridiemValue
    }
}

struct Color {
    var uiColor: UIColor
    var isSelected: Bool = false
}

struct Mail: Decodable {
    var messages: [Message]
    
    struct Message: Decodable {
        let sender: String
        let subject: String
        let body: String
        let timestamp: Double
    }
}

struct NetworkController {
    private enum Endpoint: String {
        case mailMessages = "json/email.json"
    }
    
    private static let baseUrl = "https://s3.amazonaws.com/justncode.com/"
    
    private static func urlString(for endpoint: Endpoint) -> String {
        return baseUrl + endpoint.rawValue
    }
    
    static func fetchMailMessages(_ completion: @escaping (([Mail.Message]) -> Void)) {
        if let url = URL(string: urlString(for: .mailMessages)) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                let mail = try? JSONDecoder().decode(Mail.self, from: data)
                completion(mail?.messages ?? [])
               }
           }.resume()
        }
    }
}
