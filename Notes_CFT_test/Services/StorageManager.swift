//U-N00B-or-Bot

import Foundation
import UIKit

class StorageManager {
    static let shared = StorageManager()

    let defaults = UserDefaults.standard
    
    func checkNotFirstLaunch()-> Bool {
        defaults.bool(forKey: "isNotFirstLaunch")
    }
    func setValueForLaunchChecker(){
        defaults.set(true, forKey: "isNotFirstLaunch")
    }
    
    func firstLaunchPrepare(){
        let notesList = [Note(text: "Hello, World!")]
        self.saveNotes(list: notesList)
    }
    
    
    func fetchNotes()-> [Note]{
        if let data = UserDefaults.standard.value(forKey:"notes") as? Data {
            let notesList = try? PropertyListDecoder().decode(Array<Note>.self, from: data)
            return notesList ?? [Note]()
        }
        return [Note]()
  
    
    }
    
    func saveNotes(list: [Note]){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"notes")
    }
    
    private init(){}
}
