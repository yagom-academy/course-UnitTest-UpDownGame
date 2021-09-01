
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
    func test_compareVlaue호출시_hitNumber가randomValue보다작을때_Down반환하는지() {
        // given
        let hitNumber = 10
        sut.randomValue = 5
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Down)
    }
    
    func test_compareVlaue호출시_hitNumber가randomValue보다클때_Up반환하는지() {
        // given
        let hitNumber = 5
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Up)
    }
    
    func test_compareVlaue호출시_hitNumber가randomValue과같을때_Win반환하는지() {
        // given
        let hitNumber = 10
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        XCTAssertEqual(result, .Win)
    }
    
    func test_compareVlaue호출시_tryCount가5이면서_hitNumber가randomValue과다를때_Lose반환하는지() {
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

// MARK: - makeRandomValue
extension UpDownGameTests {
    func test_makeRandomValue호출시_randomValue를_잘설정해주는지() {
        // given
        let promise = expectation(description: "It makes random value")
        
        // when
        sut.makeRandomValue {
            XCTAssertGreaterThanOrEqual(self.sut.randomValue, 0)
            XCTAssertLessThanOrEqual(self.sut.randomValue, 30)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}

// MARK: - reset
extension UpDownGameTests {
    func test_reset호출시_tryCount가0이되는지() {
        // given
        let promise = expectation(description: "It makes tryCount zero")
        
        // when
        sut.makeRandomValue {
            XCTAssertEqual(self.sut.tryCount, 0)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
