import Foundation

public struct FourBit: Equatable, Hashable {
    var value: Int
    
    public var hashValue: Int {
        return value
    }
    
    public init!(_ value: Int) {
        guard value <= 0xf && value >= 0x00 else {
            return nil
        }
        self.value = value
    }
}

public func ==(lhs: FourBit, rhs: FourBit) -> Bool {
    return lhs.value == rhs.value
}


public class FourBitEncode {
    
    private var data: [FourBit: FourBit] = {
        var dict = [FourBit: FourBit]()
        for a in 0..<0x10 {
            dict[FourBit(a)] = FourBit(a)
        }
        return dict
    }()
    
    func rand(times: Int = 100) {
        for _ in 0..<times {
            let index1 = FourBit(Int(arc4random()) % 0x10)!
            let index2 = FourBit(Int(arc4random()) % 0x10)!
            let temp = self.data[index1]
            self.data[index1] = self.data[index2]
            self.data[index2] = temp
        }
    }
    
    func reset() {
        for a in 0..<0xf {
            self.data[FourBit(a)] = FourBit(a)
        }
    }
    
    func encode(data: FourBit) -> FourBit {
        return FourBit(0)
    }
    func decode(data: FourBit) -> FourBit {
        return FourBit(0)
    }
}

extension FourBit:CustomStringConvertible {
    public var description: String {
        return String(format: "%x", self.value)
    }
}

extension FourBitEncode: CustomStringConvertible {
    public var description: String {
        var result = ""
        for index in 0..<0x10 {
            let key = FourBit(index)!
            let value = self.data[key]!
            result = result + "\(key):\(value)\n"
        }
        return result
    }
}
