//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Adrian Hernandez on 3/18/24.
//

import Foundation
import UIKit

class TriviaQuestionService {
    
    static func fetchQuestions(completion: (([TriviaQuestion]) -> Void)? = nil){
        let url = URL(string: "https://opentdb.com/api.php?amount=5")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                assertionFailure("Erro: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            
            //at this point, "data" contains data recieved from the response
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion?(response.triviaQuestion)
            }
        }
        
        task.resume()
    }

}


