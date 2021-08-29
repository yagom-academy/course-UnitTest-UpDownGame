
import XCTest
@testable import UpDownGame

class UpDownGameTests: XCTestCase {
    var sut: UpDownGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UpDownGame()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    // MARK: - compareVlaue
    func test_CompareValue_hitNumber가_randomValue보다_작을때() {
        // given
        let hitNumber = 10
        sut.randomValue = 5
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Down)
    }
    
    func test_CompareValue_hitNumber가_randomValue보다_클때() {
        // given
        let hitNumber = 5
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Up)
    }
    
    func test_CompareValue_hitNumber가_randomValue과_같을때() {
        // given
        let hitNumber = 10
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        XCTAssertEqual(result, .Win)
    }
    
    func test_CompareValue_tryCount가5이면서_hitNumber가_randomValue과_다를때() {
        // given
        let hitNumber = 7
        sut.randomValue = 10
        sut.tryCount = 5
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Lose)
    }
}
