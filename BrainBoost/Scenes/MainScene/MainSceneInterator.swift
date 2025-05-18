final class MainSceneInterator: MainBussinesLogic, CardGameDataStore {

    private let presenter: MainPresentationLogic
    private let cardGenerator: CardGenerator
    private let scoreCalculator: ScoreCalculator
    
    var gameState: MainSceneModel.GameState = .notStarted
    var cards: [[MainSceneModel.Card]] = []
    var score: Int = 0

    init(
        presenter: MainPresentationLogic,
        cardGenerator: CardGenerator,
        scoreCalculator: ScoreCalculator
    ) {
        self.presenter = presenter
        self.cardGenerator = cardGenerator
        self.scoreCalculator = scoreCalculator
    }

    func handleGame(_ request: Game.Request) {

    }







}
