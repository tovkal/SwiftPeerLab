//
//  CartHelper.swift
//  HarryPotterKataTests
//
//  Created by Lewis Black on 05/01/2019.
//  Copyright © 2019 Lewis Black. All rights reserved.
//

import XCTest
@testable import HarryPotterKata

class CartHelper {
    
    static func booksEqualsPrice(price: Double, books: HarryPotterBook...) {
        let cart = Cart(books:books)
        let cartPrice = cart.calculatePrice()
        XCTAssertEqual(price, cartPrice)
    }
}
