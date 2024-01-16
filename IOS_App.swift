// --------- FUNCTIONS ---------
/* 
- Add wins +
- Remove wins +
- Call wins +
- Add player +
- Remove player +
*/ 

let reservedKeywords: [String] = ["defaultplayer", "defaultitem"]

func formatName(toFormat name: String) -> String {
  let formattedName = name.prefix(1).uppercased() + name.lowercased().dropFirst()
  return String(formattedName)
}

struct Player {
  var name: String
  var wins: Int

  mutating func addWins(numOfAddedWins: Int) {
    self.wins = wins + numOfAddedWins
  }
  
  mutating func removeWins(numOfRemovedWins: Int) {
    if wins - numOfRemovedWins > 0 {
      self.wins = wins - numOfRemovedWins
    }
  }
}

var players: [Player] = []

func findPlayer(byName name: String) -> Player {
    if let foundPlayer = players.first(where: { $0.name == name }) {
        return foundPlayer
    } else {
        // If the player isn't found:
        return Player(name: "DefaultPlayer", wins: 0)
    }
}

func addPlayer(playerName name: String, currentWins wins: Int) {
  // In case people to use the reserved keyword "DefaultPlayer"
  if reservedKeywords.contains(name.lowercased()) {
    return print("This keyword is reserved.")
  }
  
  // Checking if the player already exists, if not, adding a new player
  let existingPlayer: Player = findPlayer(byName: name)
  
  // "DefaultPlayer" means the player doesn't exist
  if existingPlayer.name == "DefaultPlayer" {
    players.append(Player(name: name, wins: wins))
    return print("Successfully added Player \(name).")
  
  // If the player does exist, does nothing
  } else {
    return print("Player \(name) already exists.")
  }  
}

func deletePlayer(playerName name: String) {
  // Checking if player already exists, if so, removes player
  let existingPlayer: Player = findPlayer(byName: name)

  if existingPlayer.name != "DefaultPlayer" {
    guard let indexToRemove = players.firstIndex(where: { $0.name == name }) else {
      // If the player doesn't exist, does nothing
      return print("Player \(name) doesn't exist.")
    }
    players.remove(at: indexToRemove)
    return print("Successfully removed Player \(name).")
  } else {
    // In case people try to delete "DefaultPlayer"
    return print("Cannot delete this player.")
  }
}

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

// --------- TESTING FUNCTIONS ---------

// Adding a player
addPlayer(playerName: formatName(toFormat: "Koan"), currentWins: 10)
addPlayer(playerName: formatName(toFormat: "Patrik"), currentWins: 10)

var koan: Player = findPlayer(byName: formatName(toFormat: "Koan"))
var patrik: Player = findPlayer(byName: formatName(toFormat: "Patrik"))

// Adding & removing wins to a player
// koan.addWins(numOfAddedWins: 3)
// koan.removeWins(numOfRemovedWins: 5)

// Viewing the wins of a player
// Since the player may not be found (and therefore be "DefaultPlayer"), 
// this still prints out
// print("Koan has \(koan.wins) wins.")

// deletePlayer(playerName: formatName(toFormat: "Koan"))
// deletePlayer(playerName: formatName(toFormat: "DefaultPlayer"))

// --------- TESTING MARKETPLACE ---------

addItem(itemName: formatName(toFormat: "glasses"), price: 3, seller: koan)
addItem(itemName: formatName(toFormat: "phone"), price: 7, seller: koan)

removeItem(itemName: formatName(toFormat: "phone"), seller: koan)

var allItemsOfKoan: [Item] = getAllItemsOfSeller(seller: koan)
displayItems(allItemsOfSeller: allItemsOfKoan)

var koanGlasses = findItem(byName: formatName(toFormat: "glasses"), seller: koan)


