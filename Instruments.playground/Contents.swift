import UIKit
/*
 Properties and Methods
*/
class Instrument {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    func tune() -> String {
        fatalError("Implement this method for \(brand)")
    }
    func play(_ music: Music) -> String{
        return music.prepared()
    }
    func perform(_ music: Music) {
        print(tune())
        print(play(music))
    }
}

class Music{
    let notes: [String]
    init(notes:[String]) {
        self.notes = notes
    }
    func prepared()-> String{
        return notes.joined(separator:  "")
    }
}
