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
/*
 Inheritance
 */
//Piano as a subclass of the Instrument parent class. All stored properties and methods are automatically inherited by the Piano child class and available for use
class Piano : Instrument{
    let hasPedals: Bool
    //the associated values of their corresponding properties don't change dinamycally. Static keyword reflect this
    static let whiteKeys = 52
    static let blackKeys = 36
    
    init(brand:String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        //super keyword to call the parent class initializer after setting the child class
        super.init(brand: brand)
    }
    //override the ingerited tune method's implementation. This provides an implementation of tune() that doesn't call fatalError() but rather does something specific to Piano
    override func tune() -> String {
        return "Piano standar tuning for \(brand). "
    }
    override func play(_ music: Music) -> String {
      
        return play(music, usingPedals: hasPedals)
    }
    
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals{
            return "Play piano notes \(preparedNotes) with pedals"
        }
        else {
            return "Play piano notes \(preparedNotes) without pedals"

        }
    }
}
//Create piano as an instance of the Piano class
let piano = Piano(brand: "Yamaha", hasPedals: true)
piano.tune()

//music instance of the Music class
let music = Music(notes: ["C","G","F"])
piano.play(music, usingPedals: false)

piano.play(music)

Piano.whiteKeys
Piano.blackKeys





