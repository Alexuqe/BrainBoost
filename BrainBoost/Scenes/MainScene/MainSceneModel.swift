enum Game {

    enum Request {
        case startGame
        case cardSelected(position: MainSceneModel.Position)
        case pauseGame
        case resumeGame
    }

    struct Response {
        let gameState: MainSceneModel.GameState
        let cards: [[MainSceneModel.Card]]
        let score: Int
        let matchedPairs: Int
        let totalPairs: Int
        let lastSelectedPosition: MainSceneModel.Position?
        let secondSelectedPosition: MainSceneModel.Position?
    }

    struct ViewModel {
        struct CardViewModel {
            let position: MainSceneModel.Position
            let value: Int?
            let isEnabled: Bool
            let isMatched: Bool
            let shouldAnimate: Bool
        }

        let gameState: MainSceneModel.GameState
        let cards: [[CardViewModel]]
        let score: String
        let progress: String
    }
}
