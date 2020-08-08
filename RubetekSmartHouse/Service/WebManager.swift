//
//  WebManager.swift
//  RubetekSmartHouse
//
//  Created by Anton Larchenko on 08.08.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import Foundation

class WebManager {
    
    private let intercomURL = "https://storage.yandexcloud.net/rubetek-sandbox/tmp/response_1594638123041.json"
    
    func loadData(completion: @escaping ([Intercom])->()) {
        guard let url = URL(string: intercomURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let intercoms = try JSONDecoder().decode([Intercom].self, from: data)
                completion(intercoms)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}
