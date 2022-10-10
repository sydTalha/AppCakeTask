//
//  MainViewModel.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import SwiftUI

class MainViewModel: ObservableObject{
    
    let mainWorker = MainWorker()
    
    @Published var navSelection: Int?
    @Published var charactersList = [CharacterRequest.CharacterModel]()
    @Published var animationsList = [CharacterRequest.CharacterModel]()
    @Published var selectedCharacter: CharacterRequest.CharacterModel?
    
    
    init() {
        self.requestCharacters(limit: 4)
    }
    
    func requestCharacters(limit: Int){
        self.mainWorker.fetchCharacters(limit: limit) { characs, err in
            if err == ""{
                if let characters = characs{
                    self.charactersList = characters
                }
            }
            else{
                print("error occurred: \(err)")
            }
            
        }
    }
    
    func requestAnimations(limit: Int){
        self.mainWorker.fetchAnimations(limit: limit) { anims, err in
            if err == ""{
                if let animations = anims{
                    self.charactersList = animations
                }
            }
            else{
                print("error occurred: \(err)")
            }
        }
    }
    
    
    func saveAction(character: CharacterRequest.CharacterModel){
        
        var existingArray = defaults.getExistingCharacters(key: .character)
        
        print(existingArray)
        existingArray.append(character)
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(existingArray)
            defaults.set(key: .character, value: data)
        }
        catch {
            print("error occurred while encoding: \(error)")
        }
        
    }
    
    func loadSaved(){
        let existingArray = defaults.getExistingCharacters(key: .character)
        self.charactersList = existingArray
    }
    
    func navToDetailView() {
        navSelection = 0
    }
}
