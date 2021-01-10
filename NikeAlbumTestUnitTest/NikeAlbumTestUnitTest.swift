//
//  NikeAlbumTestUnitTest.swift
//  NikeAlbumTestUnitTest
//
//  Created by YICHUN ZHANG on 1/10/21.
//

import XCTest

@testable import NikeAlbumTest

class NikeAlbumTestUnitTest: XCTestCase {
    
    var sut_detail : DetailViewModel!
    var sut_main : MainViewModel!

    override func setUpWithError() throws {
        
        sut_detail = DetailViewModel()
        
        let item = MusicItem(name: "The Voice", artistName: "Lil Durk", iconurl: "", url: "", copyright: "℗ 2020 Alamo (Geffen Records)", releaseDate: "2020-12-24", genres: [MusicGenre(name: "Hip-Hop/Rap"),MusicGenre(name: "Music")])
        sut_detail.item = item
        
        
        
        sut_main = MainViewModel()
        sut_main.loadLocalData(filePath: "demo")
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        
        sut_detail = nil
        sut_main = nil
        try super.tearDownWithError()

    }

    func testDetailViewMode() throws {
        XCTAssertEqual(sut_detail.getName(),"The Voice", "Error: Name Mismatch")
        XCTAssertEqual(sut_detail.getArtist(), "Lil Durk", "Error: Artist Mismatch")
        XCTAssertEqual(sut_detail.getReleaseDate(), "2020-12-24", "Error: Artist Mismatch")
    }
    
    func testMainViewMode() throws
    {
        XCTAssertEqual(sut_main.getAlbumCount(),10,"Album Count mismatch")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}