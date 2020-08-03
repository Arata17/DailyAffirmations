//
//  Affirmation.swift
//  Daily Affirmations
//
//  Created by Мирас on 7/30/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import Foundation

protocol AffirmationManagerDelegate {
    func didUpdateAffirmation(_ affirmationManager: AffirmationManager, affirmation: AffirmationModel)
}

class AffirmationManager{
    
    var delegate: AffirmationManagerDelegate?
    
    
    func getAffirmation(){
        let urlString = "https://www.affirmations.dev"
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error fetching data \(error)")
                    return
                }
                if let safeData = data{
                    if let affirmation = self.parseJson(safeData){
                        self.delegate?.didUpdateAffirmation(self, affirmation: affirmation)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) ->  AffirmationModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(AffirmationData.self, from: data)
            let affirmation = decodedData.affirmation
            
            let affirmationModel = AffirmationModel(affirmation: affirmation)
            return affirmationModel
        }catch{
            print(error)
            return nil
        }
    }
    
}
