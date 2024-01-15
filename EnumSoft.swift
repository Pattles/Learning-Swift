// https://www.codecademy.com/paths/build-an-intermediate-ios-app-with-swiftui/tracks/exploring-recipes-swiftui/modules/swift-enumerations/projects/numero-uno-software-store
// I used a tiny bit of ChatGPT, but only when I was stuck and only for concepts, not actual code. All of the code here is written by me. 

// Write your code below
enum ProductType: String, CaseIterable {
  case aceRepository = "Ace Repository"
  case dealForcer = "Deal Forcer"
  case kadencePlanner = "Kadence Planner"
  case mailCannon = "Mail Cannon"
}

func displayProductOfferings() {
  print("There are \(ProductType.allCases.count) products:")
  for product in ProductType.allCases {
    print(product.rawValue)
  }
}

enum Edition: String, CaseIterable {
  case basic
  case premium
  case ultimate

  mutating func upgrade() {
    switch self {
      case .basic:
        self = .premium
      case .premium:
        self = .ultimate
      case .ultimate:
        print("Can't upgrade further")
    }
  }
}

enum DeliveryMethod {
  case cloudDigital(isLifetime: Bool)
  case shipping(weight: Int)
}

struct SoftwareOrder {
  var deliveryMethod: DeliveryMethod
  // var weight: Int

  var shippingCost: Int {
    switch deliveryMethod {
      case .shipping(let weight):
        return weight * 2
      case .cloudDigital:
        return 0
    }
  }
}

func sendOrderConfirmation(of productType: ProductType, in edition: Edition, by deliveryMethod: DeliveryMethod) {
  print("Thank you for purchasing the \(edition.rawValue) edition of \(productType.rawValue)!")

  switch deliveryMethod {
    case .shipping(let weight):
      let order = SoftwareOrder(deliveryMethod: .shipping(weight: weight))//, weight: weight)

      print("Your order will be shipped to you at the cost of $\(order.shippingCost).")
    case .cloudDigital(let isLifetime) where isLifetime:
      print("You have lifetime cloud access.")
    case .cloudDigital:
      print("You can access your subscription information on the cloud.")
  }
}

// 15
// displayProductOfferings()

// 17
var myEdition = Edition.basic
myEdition.upgrade()
// print(myEdition)

   
sendOrderConfirmation(of: .aceRepository, in: myEdition, by: .shipping(weight: 1))




