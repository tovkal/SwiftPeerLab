import Foundation

// Constants

let bookPrice: Double = 8

class Cart {
    
    var books: [HarryPotterBook] = []
    
    let discountByNumberOfBooks = [0, 5, 10, 20, 25]
    
    init (books: [HarryPotterBook] = []){
        self.books = books
    }
  
    func calculatePrice() -> Double {
        if books.isEmpty { return 0.0 }
        let price = books.reduce(0.0) { $0 + $1.price }
        let discount: Double = Double(discountByNumberOfBooks[books.count - 1])
        return price * (1 - discount/100.0)
    }
}

enum HarryPotterBook {
    case I, II, III, IV, V
    
    var price: Double {
        return bookPrice
    }
}
