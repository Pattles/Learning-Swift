/*
Currently archived since I don't know if it'll actually be worthwhile to implement.
*/

// --------- MARKETPLACE ---------
/*
- Add item to shop +
- Remove item from shop +
- Update item price +
- Buy item
- View all items by seller +


(Optional)
- Add item description
- Remove item description
- Update item description
*/


struct Item {
  var itemName: String
  var winsPrice: Int
  var seller: Player

  mutating func updateItemPrice(newPrice: Int) {
    if newPrice > 0 {
      self.winsPrice = newPrice
    }
  }
}

var allItems: [Item] = []

func findItem(byName name: String, seller: Player) -> Item {
  if let foundItem = allItems.first(where: { $0.itemName == name }) {
        return foundItem
    } else {
        // If the item isn't found:
        return Item(itemName: "DefaultItem", winsPrice: 0, seller: Player(name: "DefaultPlayer", wins: 0))
    }
}

func addItem(itemName: String, price: Int, seller: Player) {
  // In case the player decides to use a reserved keyword
  if reservedKeywords.contains(itemName.lowercased()) {
    return print("This keyword is reserved.")
  }

  let existingItemBySeller: Item = findItem(byName: itemName, seller: seller)

  // "DefaultItem" means the item doesn't exist
  if existingItemBySeller.itemName == "DefaultItem" {
    allItems.append(Item(itemName: itemName, winsPrice: price, seller: seller))
    return print("Successfully added \(itemName) to the shop.")
  }

  return print("\(itemName) already exists in the shop.")
}


func removeItem(itemName: String, seller: Player) {
  // In case the player decides to use a reserved keyword
  if reservedKeywords.contains(itemName.lowercased()) {
    return print("This keyword is reserved.")
  }

  let existingItemBySeller: Item = findItem(byName: itemName, seller: seller)

  if existingItemBySeller.itemName != "DefaultItem" {
    guard let indexToRemove = allItems.firstIndex(where: { $0.itemName == itemName && $0.seller.name == seller.name }) else {
      // If the item doesn't exist, does nothing
      return print("\(itemName) doesn't exist in the shop.")
    }

    allItems.remove(at: indexToRemove)
    return print("Successfully removed \(itemName) from the shop.")
  }
}

func getAllItemsOfSeller(seller: Player) -> [Item] {
  var allItemsOfSeller: [Item] = []

  // Getting all the items of seller
  for item in allItems {
    if item.seller.name == seller.name {
      allItemsOfSeller.append(item)
    }
  }
  return allItemsOfSeller
}

// Could be redundant, I'm not sure
func displayItems(allItemsOfSeller: [Item]) {
  print("\(allItemsOfSeller[0].seller.name) is selling the following items:")
  for item in allItemsOfSeller {
    print("\(item.itemName): \(item.winsPrice) wins")
  }
  return
}

// --------- TESTING MARKETPLACE ---------

addItem(itemName: formatName(toFormat: "glasses"), price: 3, seller: koan)
addItem(itemName: formatName(toFormat: "phone"), price: 7, seller: koan)

removeItem(itemName: formatName(toFormat: "phone"), seller: koan)

var allItemsOfKoan: [Item] = getAllItemsOfSeller(seller: koan)
displayItems(allItemsOfSeller: allItemsOfKoan)

var koanGlasses = findItem(byName: formatName(toFormat: "glasses"), seller: koan)
