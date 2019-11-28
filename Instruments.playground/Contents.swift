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

class Guitar: Instrument{
    let stringGauge: String
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}
/*
 This creates a new class guitar tha adds the idea of string gauge as a text string to the instrument base class. like instrument, guitar is considered a abstract type whose tune() and play(_:) methods need to be overriden in a subclasss. This is why it is someimes called a intermediate abstract base class.
 */


class AcousticGuitar: Guitar {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on frets \(preparedNotes)."
    }
}

let acousticGuitar = AcousticGuitar(brand: "Roland", stringGauge: "light")
acousticGuitar.tune()
acousticGuitar.play(music)

// 1. Define the Amplifier class
class Amplifier {
    
    private var _volume: Int
    /*  Only can be accessed inside of the Amplifier class.
     Is hidden from outside users
     the unserscore at the beginning of the name emphasizes that it is a private implementation . (only convention)
     */
    
    private(set) var isOn: Bool
    /*  Canbe read by outside users but no written to private(set)
     */
    
    init() {
        isOn = false
        _volume = 0
    }
    
    // 4
    func plugIn() {
        isOn = true
    }
    
    func unplug() {
        isOn = false
    }
    
    // computing property volume wraps the private stored property _volume
    var volume: Int {
        // Getter drops the volume to 0 if it's not plugged in
        get {
            return isOn ? _volume : 0
        }
        // The volume will always be clamped to a certain value between 0 and 10 inside the setter. No setting the amp to 11
        set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}

// 1
class ElectricGuitar: Guitar {
    // 2
    let amplifier: Amplifier
    
    // 3
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    // 4
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    
    // 5
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}


class BassGuitar: Guitar {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play bass line \(preparedNotes) at volume \(amplifier.volume)."
    }
}

let amplifier = Amplifier()
let electricGuitar = ElectricGuitar(brand: "Gibson", stringGauge: "medium", amplifier: amplifier)
electricGuitar.tune()

let bassGuitar = BassGuitar(brand: "Fender", stringGauge: "heavy", amplifier: amplifier)
bassGuitar.tune()

// Notice that because of class reference semantics, the amplifier is a shared
// resource between these two guitars.

bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.unplug()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.plugIn()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume
