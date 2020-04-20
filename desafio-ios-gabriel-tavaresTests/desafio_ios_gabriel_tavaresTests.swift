//
//  desafio_ios_gabriel_tavaresTests.swift
//  desafio-ios-gabriel-tavaresTests
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import XCTest
import UIKit
@testable import desafio_ios_gabriel_tavares

class desafio_ios_gabriel_tavaresTests: XCTestCase {
    
    
    func testCharacterDetailView() {
        CharacterRequest().getCharactersByOffset(offset:0 ) { result in
        switch result {
        case .failure(let error):
            print (error)
        case .success(let characters):
            var character = characters[0]
            character.name = "Iron Man"
            character.description = ""
            let characterDetailViewModel = CharacterDetailViewModel(character: character)
            XCTAssertEqual("", characterDetailViewModel.description)
            }
        }
    }
    
    func testCharacterView() {
        CharacterRequest().getCharactersByOffset(offset:0 ) { result in
        switch result {
        case .failure(let error):
            print (error)
        case .success(let characters):
            let characterViewModel = CharacterViewModel(characters: characters)
            XCTAssertEqual(characters[0].name, characterViewModel.name(index: 0))
            }
        }
    }

    /*
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */
}
