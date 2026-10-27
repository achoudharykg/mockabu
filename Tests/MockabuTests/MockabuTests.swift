import XCTest
@testable import Mockabu

final class MockabuTests: XCTestCase {
    func testInterceptsAndReturnsHardcodedResponse() async throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let url = URL(string: "https://example.com/anything")!
        let (data, response) = try await session.data(from: url)

        let body = String(decoding: data, as: UTF8.self)
        XCTAssertEqual(body, #"{"ok":true}"#)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
    }
}
