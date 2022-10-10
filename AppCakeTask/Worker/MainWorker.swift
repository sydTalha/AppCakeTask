//
//  AnimationWorker.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import Foundation


class MainWorker{
    func fetchCharacters(limit: Int, completion: @escaping ([CharacterRequest.CharacterModel]?, String) -> Void){
        let params = ["limit": "\(limit)", "type": "Character"]
        requestHandler.get(resource: "", params).response { response in
            switch response.result{
            case .success:
                do{
                    let decodedResponse = try JSONDecoder().decode(CharacterRequest.Response.self, from: response.data!)
                    //print(decodedResponse.results.count)
                    if let result = decodedResponse.results{
                        completion(result, "")
                    }
                } catch let err{
                    print("error parsing: \(err)")
                }
                print(response)
                
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    func fetchAnimations(limit: Int, completion: @escaping ([CharacterRequest.CharacterModel]?, String) -> Void){
        let params = ["limit": "\(limit)", "type": "Motion,MotionPack"]
        requestHandler.get(resource: "", params).response { response in
            switch response.result{
            case .success:
                do{
                    let decodedResponse = try JSONDecoder().decode(CharacterRequest.Response.self, from: response.data!)
                    //print(decodedResponse.results.count)
                    if let result = decodedResponse.results{
                        completion(result, "")
                    }
                } catch let err{
                    print("error parsing: \(err)")
                }
                print(response)
                
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
            }
        }
    }
    
}
