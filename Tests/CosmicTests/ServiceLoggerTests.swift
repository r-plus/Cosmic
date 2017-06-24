//
//  ServiceLoggerTests.swift
//  Cosmic
//
//  Created by Jack Newcombe on 23/06/2017.
//  Copyright © 2017 Jack Newcombe. All rights reserved.
//

import XCTest
@testable import Cosmic

class ServiceLoggerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogzLogger() {
        
        let logger = LogzLogger(withToken: "MY_TOKEN")
        
        logger.sslEnabled = true
        XCTAssertEqual(logger.config!.url, LogzServiceConfig.httpsUri)
        
        logger.sslEnabled = false
        XCTAssertEqual(logger.config!.url, LogzServiceConfig.httpUri)
        
        XCTAssertEqual(logger.config!.method, LogzServiceConfig.method)
        
        XCTAssertEqual(logger.config!.query[LogzServiceConfig.tokenKey]!, "MY_TOKEN")
    }
    
    func testPapertrailLogger() {
        
        let logger = PapertrailLogger()
        
        XCTAssert(logger.formatters.contains { ($0 as! SyslogFormatter) === logger.syslogFormatter })
        
    }
    
}