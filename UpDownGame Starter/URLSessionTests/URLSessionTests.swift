//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import XCTest
@testable import UpDownGame

class URLSessionTest: XCTestCase {
    var sut: URLSession!
    let url = URL(string: "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=30&count=1")!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_URL요청시_상태코드200번이_돌아오는지() {
        // given
        let promise = expectation(description: "StatusCode is 200")
        
        // when
        let task = sut.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let statusCode = response.statusCode
            // then
            XCTAssertEqual(statusCode, 200)
            promise.fulfill()
        }
        
        task.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func test_URL요청시_에러가_nil인지() {
        // gitven
        let promise = expectation(description: "Error is nil")
        
        // when
        let task = sut.dataTask(with: url) { data, response, error in
            // then
            XCTAssertNil(error)
            promise.fulfill()
        }
        
        task.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func test_URL요청시_0에서30까지의randomValue가_들어오는지() {
        // given
        let promise = expectation(description: "RandomValue is in 0 to 30")
        
        // when
        let task = sut.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            guard let newValue = try? JSONDecoder().decode([Int].self, from: data).first else {
                return
            }
            
            // then
            XCTAssertGreaterThanOrEqual(newValue, 0)
            XCTAssertLessThanOrEqual(newValue, 30)
            promise.fulfill()
        }
        
        task.resume()
        wait(for: [promise], timeout: 10)
    }
}
