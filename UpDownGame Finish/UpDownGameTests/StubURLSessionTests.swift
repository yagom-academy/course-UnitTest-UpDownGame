
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
    
    func test_3이라는값을_받았을때() {
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
    
    func test_random값을_받아올때() {
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