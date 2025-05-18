
enum MainSceneModel {

    struct Card: Equatable {
        let id: Int
        let value: Int
        var isFlipped: Bool
        var isMatches: Bool

        mutating func flip() {
            isFlipped.toggle()
        }

        mutating func match() {
            isMatches.toggle()
        }
    }

    struct Position: Equatable {
        let row: Int
        let column: Int
    }

    enum GameState {
        case notStarted
        case inProgress
        case paused
        case finished
    }
}
