//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

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

    // MARK: - compareValue
    func test_compareValue호출시_hitNumber가randomValue보다작을때_Down반환하는지() {
        // given
        let hitNumber = 10
        sut.randomValue = 5
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Down)
    }
    
    func test_compareValue호출시_hitNumber가randomValue보다클때_Up반환하는지() {
        // given
        let hitNumber = 5
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        // then
        XCTAssertEqual(result, .Up)
    }
    
    func test_compareValue호출시_hitNumber가randomValue와같을때_Win반환하는지() {
        // given
        let hitNumber = 10
        sut.randomValue = 10
        
        // when
        let result = sut.compareValue(with: hitNumber)
        
        XCTAssertEqual(result, .Win)
    }
    
    func test_compareValue호출시_tryCount가5이면서_hitNumber가randomValue와다를때_Lose반환하는지() {
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
    func test_makeRandomValue호출시_randomValue를_0에서30까지숫자로설정해주는지() {
        // given
        let promise = expectation(description: "It makes random value")
        sut.randomValue = 50 // 기본값이 0~30에 포함되면 무조건 테스트에 통과하므로 범위에서 벗어난 값을 할당
        
        // when
        sut.makeRandomValue {
            // then
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
        sut.tryCount = 4 // 기본값인 0으로 테스트를 진행하면 무조건 테스트에 통과하므로 0이 아닌 값을 할당
        
        // when
        sut.reset {
            XCTAssertEqual(self.sut.tryCount, 0)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
