//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import XCTest
@testable import UpDownGame

class StubURLSessionTests: XCTestCase {
    var sut: UpDownGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UpDownGame()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - reset
    func test_URL요청으로_3이라는값을받아올때_randomValue값설정이잘되는지() {
        // given
        let promise = expectation(description: "")
        let url = URL(string: "http://www.randomnumberapi.com/api/v1.0/random?min=1&max=30&count=1")!
        let data = "[3]".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummy: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.reset {
            // then
            XCTAssertEqual(self.sut.randomValue, 3)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_URL요청으로_0부터30까지의random값을받아올때_randomValue값설정이잘되는지() {
        // given
        let promise = expectation(description: "")
        let randomValue = Int.random(in: 0...30)
        let url = URL(string: "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=30&count=1")!
        let data = "[\(randomValue)]".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummy: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.reset {
            // then
            XCTAssertEqual(self.sut.randomValue, randomValue)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
