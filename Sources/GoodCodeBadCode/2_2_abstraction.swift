import Foundation

/// HTTP通信の中で何が行われているかどうかを抽象化している
///
///	中に潜む複雑なロジック
/// - 送信メッセージのシリアライズ
/// - HTTPに関わる複雑な処理
/// - TCP通信
/// - ユーザーのネットワーク設定
/// - データから無線通信への変換
/// - データ送信時のエラーと訂正
actor HttpConnection {

	var url: URL

	init(url: URL) {
		self.url = url
	}

	static func connect(string: String) async throws -> HttpConnection {
		guard let url = URL(string: string) else {
			throw Error.invalidURL(string)
		}
		return .init(url: url)
	}
	func send(_ message: String) async throws {
		var request = URLRequest(url: url)
		request.httpBody = try JSONSerialization.data(withJSONObject: [
			"message": message
		])
		let (_, response) = try await URLSession.shared.data(for: request)
		print(response)
	}

	enum Error: LocalizedError {
		case invalidURL(String)
	}
}

func main() async throws {
	let connection = try await HttpConnection.connect(
		string: "http://example.com/server"
	)
	try await connection.send("Hello World")
}

