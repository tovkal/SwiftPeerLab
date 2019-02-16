import XCTest
@testable import HarryPotterKata

class CartTests: XCTestCase {


    func testEmptyCartPriceIs0() {
        CartHelper.booksEqualsPrice(price: 0)
    }

    func testOneBookPriceIs8() {
        CartHelper.booksEqualsPrice(price: 8, books: .I)
    }
    
    func testTwoDifferentBooksPriceHave5PercentDiscount() {
        CartHelper.booksEqualsPrice(price: 15.20, books: .I, .II)
    }
    
    func testThreeDifferentBooksPriceHave5PercentDiscount() {
        CartHelper.booksEqualsPrice(price: 21.60, books: .I, .II, .III)
    }
    
    func testFourDifferentBooksPriceHave5PercentDiscount() {
        CartHelper.booksEqualsPrice(price: 25.60, books: .I, .II, .III, .IV)
    }
    
    func testFiveDifferentBooksPriceHave5PercentDiscount() {
        CartHelper.booksEqualsPrice(price: 30.00, books: .I, .II, .III, .IV, .V)
    }
}
