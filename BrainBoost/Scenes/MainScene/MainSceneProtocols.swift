import Foundation

// MARK: Interactor
protocol MainBussinesLogic: AnyObject {
    func handleGame(_ request: Game.Request )
}

// MARK: Presenter
protocol MainPresentationLogic: AnyObject {
    func presentGame(_ response: Game.Response)
}

// MARK: ViewController
protocol MainDisplayLogic: AnyObject {
    func displayGame(_ viewModel: Game.ViewModel)
}

//MARK: Data
protocol CardGameDataStore {
    var gameState: MainSceneModel.GameState { get }
    var cards: [[MainSceneModel.Card]] { get }
    var score: Int { get }
}

//MARK: Generator
protocol CardGeneratorProtocol {
    func generateCards() -> [[MainSceneModel.Card]]
}

//MARK: Score
protocol ScoreCalculatorProtocol {
    func calculateScore(mathedPairs: Int, time: TimeInterval) -> Int
}
