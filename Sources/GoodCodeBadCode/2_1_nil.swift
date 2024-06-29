struct Element {}

// nilの概念がある世界
func getFifth(of elements: [Element]) -> Element? {
	if elements.count < 5 {
		return nil
	}
	return elements[4]
}

// もしSwiftにnil(Optional)がなければ、自分で定義する
enum CustomOptional<Value> {
	case some(_ value: Value)
	case none
}

func getFifth(of elements: [Element]) -> CustomOptional<Element> {
	if elements.count < 5 {
		return .none
	}
	return .some(elements[4])
}
