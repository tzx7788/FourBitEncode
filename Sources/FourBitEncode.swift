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
    
    public init(){}
    
    public func rand(_ times: Int = 100) {
        for _ in 0..<times {
            let index1 = FourBit(Int(arc4random()) % 0x10)!
            let index2 = FourBit(Int(arc4random()) % 0x10)!
            let temp = self.data[index1]
            self.data[index1] = self.data[index2]
            self.data[index2] = temp
        }
    }
    
    public func reset() {
        for a in 0..<0xf {
            self.data[FourBit(a)] = FourBit(a)
        }
    }
    
    public func encode(_ data: FourBit) -> FourBit! {
        return self.data[data]
    }
    public func decode(_ data: FourBit) -> FourBit! {
        for (key, value) in self.data {
            if value == data {
                return key
            }
        }
        return FourBit(0)
    }
}

extension FourBit: CustomStringConvertible {
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

extension UInt8 {
    public func split() -> (FourBit, FourBit) {
        let a = FourBit((Int(self) >> 4) & 0xf)!
        let b = FourBit((Int(self)) & 0xf)!
        return (a,b)
    }
}

public func merge(_ a: FourBit, _ b: FourBit) -> UInt8 {
    var result = a.value << 4
    result = result + b.value
    return UInt8(result)
}

