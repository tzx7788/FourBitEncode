import XCTest
@testable import FourBitEncode

class FourBitEncodeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let a = FourBitEncode()
        print(a)
        a.rand()
        print(a)
    }


    static var allTests : [(String, (FourBitEncodeTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
