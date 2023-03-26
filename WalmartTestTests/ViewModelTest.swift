//
//  ViewModelTest.swift
//  WalmartTestTests
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import XCTest
@testable import WalmartTest

final class ViewModelTest: XCTestCase {

    var viewModel: ViewModel!

    override func setUp() {
        viewModel = ViewModel(with: PlanetaryRepository(with: PlanetaryMockService()), fileManager: MockLocalFileManager())
        viewModel.delegate = self
        viewModel.loadImage()
    }
    
    override func tearDown() {
        viewModel.fileManager?.deleteTheOldFile()
        viewModel = nil
    }
    
    func testDateFomramatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date: Date? = dateFormatter.date(from: "2016-02-29")
        XCTAssertTrue("2016-02-29" == date?.getFormattedDate(format: "yyyy-MM-dd"))
    }

    
    func testAllData() {
        XCTAssertTrue("2023-03-24" == viewModel.imageDate)
        XCTAssertTrue("Outbound Comet ZTF" == viewModel.title)
        XCTAssertTrue("https://apod.nasa.gov/apod/image/2303/C2022E3_230321_1024.jpg" == viewModel.imageUrl)
        XCTAssertTrue("Former darling of the northern sky Comet C/2022E3 (ZTF) has faded. During its closest approach to our fair planet in early February Comet ZTF was a mere 2.3 light-minutes distant. Then known as the green comet, this visitor from the remote Oort Cloud is now nearly 13.3 light-minutes away. In this deep image, composed of exposures captured on March 21, the comet still sports a broad, whitish dust tail and greenish tinted coma though. Not far on the sky from Orion's bright star Rigel, Comet ZTF shares the field of view with faint, dusty nebulae and distant background galaxies. The telephoto frame is crowded with Milky Way stars toward the constellation Eridanus. The influence of Jupiter's gravity on the comet's orbit as ZTF headed for the inner solar system, may have set the comet on an outbound journey, never to return." == viewModel.explanation)
        XCTAssertTrue(nil == viewModel.imageData)
    }
    
    func testLocalImageForToday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        viewModel.todayDate = dateFormatter.date(from: "2023-03-24")
        viewModel.loadImage()
        let img = UIImage(named: "icon")
        XCTAssert(viewModel.imageData == img?.pngData())
    }
    
    func testOldLocalImage() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        viewModel.todayDate = dateFormatter.date(from: "2023-03-25")
        viewModel.loadImage()
        XCTAssert(viewModel.imageData == nil)
    }
}


extension ViewModelTest: ListServiveDelegates {
    func localImageLoaded(error: String?) {
        
    }
    
    func serverDataSucces() {
        
    }
    
    func errorAccored(error: String) {
        
    }
}