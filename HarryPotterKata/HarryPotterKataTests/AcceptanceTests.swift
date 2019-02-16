import XCTest
@testable import HarryPotterKata

class AcceptanceTests: XCTestCase {

    func test1BookPriceIs8() {
        CartHelper.booksEqualsPrice(price: 8, books: .I)
    }
    
    func test2DifferentsBookPriceIs1520() {
        CartHelper.booksEqualsPrice(price: 15.20, books: .I, .II)
    }
    
    func test3DifferentsBookPriceIs2160() {
        CartHelper.booksEqualsPrice(price: 21.60, books: .I, .II, .III)
    }
    
    func test4DifferentsBookPriceIs2560() {
        CartHelper.booksEqualsPrice(price: 25.60, books: .I, .II, .III, .IV)
    }
    
    func test5DifferentsBookPriceIs3000() {
        CartHelper.booksEqualsPrice(price: 30.00, books: .I, .II, .III, .IV, .V)
    }
}
