//
//  NetworkTests.swift
//  WeatherTrackerTests
//
//  Created by Thomas Murray on 22/11/2020.
//

import XCTest
import Mocker
import Alamofire

@testable import WeatherTracker

final class MockedData {
    static let exampleJson = Bundle(for: MockedData.self).url(forResource: "WeatherData", withExtension: "json")!

    enum MockErrors: Error {
        case failedRequestError
    }
}


class MovieNetworkingTests: XCTestCase {
    

    // MARK: - Properties
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=san+francisco&appid=94637947bc1853f73b1ccc559fbd44a8")!


    // MARK: - Helepr Methods
    private func createRequestFor(url: URL, statusCode: Int, dataType: Mock.DataType, requestError: Error? = nil, data: [Mock.HTTPMethod: Data]) -> Mock {
        if requestError != nil {
            return Mock(url: url, dataType: dataType, statusCode: statusCode, data: data, requestError: requestError)
        } else {
            return Mock(url: url, dataType: dataType, statusCode: statusCode, data: data)
        }
    }

    // MARK: - Test Methods
    func testThatANetworkRequestIsMadeAndIsSuccessfulForStatusCode200() {
        let mockManager = WeatherResultsManager<WeatherRequest>()
        let mock = createRequestFor(url: url, statusCode: 200, dataType: .json, data: [.get: MockedData.exampleJson.dataRepresentation])
        mock.register()
        mockManager.resultsHandler = {
            switch $0 {
            case .success(let data):
                XCTAssertNotNil(data, "The data retrived is not nil")
            case .failure(let error):
                XCTFail("Request failed \(error.localizedDescription)")
            }
        }
        mockManager.search(endpoint: .weather("san francisco"))
    }

    func testThatANetworkRequestIsMadeAndFailsForStatusCode500() {
        let expectation = XCTestExpectation(description: "Got no data and got error 500")
        let mockManager = WeatherResultsManager<WeatherRequest>()
        let mock = createRequestFor(url: url, statusCode: 500, dataType: .json, requestError: MockedData.MockErrors.failedRequestError, data: [.get: Data()])
        mock.register()
        mockManager.resultsHandler = {
            switch $0 {
            case .success(let data):
                XCTAssertNil(data, "We got no data")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription == MockedData.MockErrors.failedRequestError.localizedDescription)
                XCTAssertNotNil(error, "We got the error")
            }
            expectation.fulfill()
        }
        mockManager.search(endpoint: .weather("san francisco"))
    }

}
