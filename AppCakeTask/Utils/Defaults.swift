//
//  Defaults.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/10/22.
//

import Foundation

let defaults = Defaults()

class Defaults {
    private let def: UserDefaults
    init() {
        def = UserDefaults.standard
    }
    
    func get(key: LocalKeys) -> Any? {
        return def.object(forKey: key.rawValue)
    }
    
    func getExistingCharacters(key: LocalKeys) -> [CharacterRequest.CharacterModel]{
        guard let data = def.object(forKey: key.rawValue) as? Data else {
            print("'character' not found in UserDefaults")
            return [CharacterRequest.CharacterModel]()
        }

        do {
            let decoder = JSONDecoder()
            let array = try decoder.decode([CharacterRequest.CharacterModel].self, from: data)
            return array
        }
        catch{
            print("error occurred while decoding: \(error)")
        }
        return [CharacterRequest.CharacterModel]()
        
    }
    
    func set(key: LocalKeys, value: Any) {
        def.set(value, forKey: key.rawValue)
    }
    
    func wipe() {
        let domain = Bundle.main.bundleIdentifier!
        def.removePersistentDomain(forName: domain)
    }
    
    func remove(key: LocalKeys) {
        def.removeObject(forKey: key.rawValue)
    }
}

enum LocalKeys: String{
    case character
    case animation
}
