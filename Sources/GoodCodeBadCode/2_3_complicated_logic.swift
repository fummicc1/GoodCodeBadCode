struct Vehicle {
	var hasBeenScraped: Bool {
		true // Stub
	}
	func getMostRecentPurchase() -> Purchase? {
		nil // Stub
	}
}
struct Letter {}
enum Address {
	case scrapYard
	case showRoom
}
struct Purchase {
	func getBuyersAddress() -> Address? {
		.scrapYard // Stub
	}
}
enum SendConfirmation {
	case succcess
	case fail
}

func send(letter: Letter, to ownerAddress: Address) -> SendConfirmation {
	// Stub
	.succcess
}

// 一つの関数に全てのロジックを入れている
func sendOwnerALetter_Bad(
	vehicle: Vehicle,
	letter: Letter
) async throws -> SendConfirmation? {
	let ownersAddress: Address?

	if vehicle.hasBeenScraped {
		ownersAddress = .scrapYard
	} else {
		let mostRecentPurchase = vehicle.getMostRecentPurchase()
		if let mostRecentPurchase {
			ownersAddress = mostRecentPurchase.getBuyersAddress()
		} else {
			ownersAddress = .showRoom
		}
	}
	if let ownersAddress {
		return send(letter: letter, to: ownersAddress)
	}
	return nil
}


// 関数を分けよう
func sendOwnerALetter_Good(
	vehicle: Vehicle,
	letter: Letter
) async throws -> SendConfirmation? {
	let ownerAddress = getOwnersAddress(vehicle: vehicle)
	if let ownerAddress {
		return send(letter: letter, to: ownerAddress)
	}
	return nil
}

func getOwnersAddress(vehicle: Vehicle) -> Address? {
	if vehicle.hasBeenScraped {
		return .scrapYard
	}
	let mostRecentPurchase = vehicle.getMostRecentPurchase()
	if let mostRecentPurchase {
		return mostRecentPurchase.getBuyersAddress()
	}
	return .showRoom
}
