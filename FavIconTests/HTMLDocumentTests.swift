//
// FavIcon
// Copyright (C) 2015 Leon Breedt
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
@testable import FavIcon

class HTMLDocumentTests : XCTestCase {
    func testHTMLFragment() {
        let document = HTMLDocument(string: "<html></html>")
        let elements = document.query("/html")
        
        XCTAssertEqual(1, elements.count)
        XCTAssertEqual("html", elements[0].name)
        XCTAssertEqual(0, elements[0].children.count)
    }
    
    func testHTMLElementAttributes() {
        let document = HTMLDocument(string: "<html lang='en-us'></html>")
        
        XCTAssertEqual(1, document.children.count)
        
        let html = document.children[0]
        
        XCTAssertEqual(1, html.attributes.count)
        XCTAssertEqual("en-us", html.attributes["lang"])
    }
    
    func testHTMLElementsShouldNotBeCreatedMultipleTimes() {
        let document = HTMLDocument(string: "<html><head></head><body></body></html>")
        
        let children1 = document.children
        let children2 = document.children
        
        XCTAssertTrue(children1[0] === children2[0])
    }

    func testHTMLElementWithChildren() {
        let document = HTMLDocument(string: "<html><body><p id='test'>some text</p></html>")
        let elements = document.query("/html/body")
        
        XCTAssertEqual(1, elements.count)
        XCTAssertEqual("body", elements[0].name)
        XCTAssertEqual(1, elements[0].children.count)
        XCTAssertEqual("p", elements[0].children[0].name)
    }

    func testMalformedHTML() {
        let document = HTMLDocument(string: "<html <body><p id='test'>some text</p></body>")
        let elements = document.query("//body")
        
        XCTAssertEqual(1, elements.count)
        XCTAssertEqual("body", elements[0].name)
        XCTAssertEqual(1, elements[0].children.count)
        XCTAssertEqual("p", elements[0].children[0].name)
    }
}
