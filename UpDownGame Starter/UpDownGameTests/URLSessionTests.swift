
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

    func test_URL요청상태코드200번이_돌아오는지() {
        let task = sut.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let statusCode = response.statusCode
            XCTAssertEqual(statusCode, 200)
        }
        
        task.resume()
    }
}



