//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import Foundation

class UpDownGame {
    var randomValue: Int = 0
    var tryCount: Int = 0
    var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func makeRandomValue(completionHandler: @escaping () -> Void) {
        let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=30&count=1"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                guard let newValue = try JSONDecoder().decode([Int].self, from: data).first else {
                    return
                }
                
                self.randomValue = newValue
                completionHandler()
            } catch {
                return
            }
        }
        
        task.resume()
    }
    
    func reset(completionHandler: @escaping () -> Void) {
        tryCount = 0
        makeRandomValue {
            completionHandler()
        }
    }
    
    func compareValue(with hitNumber: Int) -> HitResult {
        if tryCount >= 5 {
           return .Lose
        } else if randomValue == hitNumber {
            return .Win
        } else if hitNumber > randomValue {
            return .Down
        } else {
            return .Up
        }
    }
}
