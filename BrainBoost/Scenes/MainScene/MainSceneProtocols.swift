import Foundation

protocol MainBussinesLogic: AnyObject {
    func handleGame(_ request: Game.Request )
}

protocol MainPresentationLogic: AnyObject {
    func presentGame(_ response: Game.Response)
}

protocol MainDisplayLogic: AnyObject {
    func displayGame(_ viewModel: Game.ViewModel)
}

protocol CardGameDataStore {
    var gameState: MainSceneModel.GameState { get }
    var cards: [[MainSceneModel.Card]] { get }
    var score: Int { get }
}

protocol CardGenerator {
    func generateCards() -> [[MainSceneModel.Card]]
}

protocol ScoreCalculator {
    func calculateScore(mathedPairs: Int, time: TimeInterval) -> Int
}
