//
//  ViewControllerUnitTest.swift
//  NikeAlbumTestUnitTest
//
//  Created by YICHUN ZHANG on 1/10/21.
//

import XCTest
@testable import NikeAlbumTest

class MainViewPresenterMock: MainViewPresenter {
    
    private(set) var onViewLoadedCalled = false
    
    func onViewLoaded() {
        onViewLoadedCalled = true
    }
}

class DetailViewPresenterMock: DetailViewPresenter {
    
    private(set) var onViewLoadedCalled = false
    
    func onViewLoaded() {
        onViewLoadedCalled = true
    }
}

class ViewControllerUnitTest: XCTestCase {
    
    let main_presenter = MainViewPresenterMock()
    
    func make_main_SUT() -> MainViewController
    {
        let sut = MainViewController.init()
        sut.presenter = main_presenter
        sut.loadViewIfNeeded()
        
        return sut
    }
    
    let detail_presenter = DetailViewPresenterMock()
    
    func make_detail_SUT() -> DetailViewController
    {
        let sut = DetailViewController.init()
        
        sut.presenter = detail_presenter
        sut.loadViewIfNeeded()
        return sut
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainViewControler() throws {
        
        let sut = make_main_SUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(main_presenter.onViewLoadedCalled)
        
        sut.viewModel?.loadLocalData(filePath: "demo")
        
        XCTAssertEqual(sut.viewModel?.getAlbumCount(), 10)
        
        XCTAssertEqual(sut.contentView?.numberOfRows(inSection: 0),10)
        
    }
    
    func testDetailViewController() throws {
        
        let sut = make_detail_SUT()
        
        let item = MusicItem(name: "The Voice", artistName: "Lil Durk", iconurl: "", url: "", copyright: "℗ 2020 Alamo (Geffen Records)", releaseDate: "2020-12-24", genres: [MusicGenre(name: "Hip-Hop/Rap"),MusicGenre(name: "Music")])
        
        sut.setItem(item: item)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(detail_presenter.onViewLoadedCalled)
        
        XCTAssertEqual(sut.viewModel?.getName(),"The Voice", "Error: Name Mismatch")
        XCTAssertEqual(sut.viewModel?.getArtist(), "Lil Durk", "Error: Artist Mismatch")
        XCTAssertEqual(sut.viewModel?.getReleaseDate(), "2020-12-24", "Error: Artist Mismatch")

    }
}
