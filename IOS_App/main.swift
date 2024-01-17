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
  // var itemsOwned: [Item]
  // ^^ Check shop.swift for more info 

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




