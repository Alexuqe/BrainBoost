import Foundation

final class MainSceneInterator: MainBussinesLogic, CardGameDataStore {

//    MARK: Protocols
    private let presenter: MainPresentationLogic
    private let cardGenerator: CardGeneratorProtocol
    private let scoreCalculator: ScoreCalculatorProtocol

//    MARK: - Private Properties
    private(set) var gameState: MainSceneModel.GameState = .notStarted
    private(set) var cards: [[MainSceneModel.Card]] = []
    private(set) var score: Int = 0

    private var firstSelectedPosition: MainSceneModel.Position?
    private var secondSelectedPosition: MainSceneModel.Position?
    private var matchedPairs: Int = 0
    private let totalPairs: Int = 8
    private var isCheckingMatch = false

//    MARK: - Init
    init(
        presenter: MainPresentationLogic,
        cardGenerator: CardGeneratorProtocol,
        scoreCalculator: ScoreCalculatorProtocol
    ) {
        self.presenter = presenter
        self.cardGenerator = cardGenerator
        self.scoreCalculator = scoreCalculator
    }

//    MARK: - Handle Game
    func handleGame(_ request: Game.Request) {
        switch request {
            case .startGame:
                handleGameStart()
            case .cardSelected(let position):
                handleCardSelected(at: position)
            case .pauseGame:
                handleGamePaused()
            case .resumeGame:
                handleGameResume()
        }
    }

    private func handleGameStart() {
        gameState = .notStarted
        score = 0
        matchedPairs = 0
        firstSelectedPosition = nil
        secondSelectedPosition = nil
        cards = cardGenerator.generateCards()

        notifyPresenter()
    }

    private func handleGamePaused() {
        guard gameState == .inProgress else { return }

        gameState = .paused

        let response = Game.Response(
            gameState: gameState,
            cards: cards,
            score: score,
            matchedPairs: matchedPairs,
            totalPairs: totalPairs,
            lastSelectedPosition: nil,
            secondSelectedPosition: nil
        )

        presenter.presentGame(response)
    }

    private func handleGameResume() {
        if gameState == .notStarted || gameState == .paused {
            gameState = .inProgress
        }

        if firstSelectedPosition != nil {
            guard let position = firstSelectedPosition else { return }

            cards[position.row] [position.column].flip()
            firstSelectedPosition = nil
        }

        let response = Game.Response(
            gameState: gameState,
            cards: cards,
            score: score,
            matchedPairs: matchedPairs,
            totalPairs: totalPairs,
            lastSelectedPosition: nil,
            secondSelectedPosition: nil
        )

        presenter.presentGame(response)
    }

    private func handleCardSelected(at position: MainSceneModel.Position) {
        guard
            gameState == .inProgress,
            isValidePosition(position: position),
            !isCardMathed(at: position),
            !isCheckingMatch
        else { return }

        flipCard(at: position)

        if let firstPosition = firstSelectedPosition {
            if firstPosition != position {
                firstSelectedPosition = nil
                checkMatch(first: firstPosition, and: position)
            }
        } else {
            firstSelectedPosition = position
            notifyPresenter()
        }

        checkGameCompletion()
    }

//    MARK: - Check Cards
    private func checkMatch(
        first: MainSceneModel.Position,
        and second: MainSceneModel.Position
    ) {
        isCheckingMatch = true
        let firstCard = cards[first.row] [first.column]
        let secondCard = cards[second.row] [second.column]

        showSecondCard(at: second)

        let matchCheckDelay = DispatchTime.now() + 0.5
        let flipBackDelay = DispatchTime.now() + 0.6

        DispatchQueue.main.asyncAfter(deadline: matchCheckDelay) { [weak self] in
            guard let self else { return }

            if firstCard.value == secondCard.value {
                self.handleMatchesCard(first: first, and: second)
            } else {
                self.handleUnmatchedCard(first: first, and: second)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: flipBackDelay) { [weak self] in
            guard let self else { return }
            self.resetSelectedPosition()
            isCheckingMatch = false
        }
    }

    private func showSecondCard(at position: MainSceneModel.Position) {
        secondSelectedPosition = position
        notifyPresenter()
    }

    private func handleMatchesCard(first: MainSceneModel.Position, and second: MainSceneModel.Position) {
        matchedPairs += 1
        cards[first.row][first.column].match()
        cards[second.row][second.column].match()

        score = scoreCalculator.calculateScore(
            mathedPairs: matchedPairs,
            time: 0
        )
    }

    private func handleUnmatchedCard(first: MainSceneModel.Position, and second: MainSceneModel.Position) {
        firstSelectedPosition = first
        secondSelectedPosition = second

        cards[first.row] [first.column].flip()
        cards[second.row] [second.column].flip()

        notifyPresenter()
    }

    private func resetSelectedPosition() {
        firstSelectedPosition = nil
        secondSelectedPosition = nil
        notifyPresenter()
    }

    private func checkGameCompletion() {
        if matchedPairs == totalPairs {
            gameState = .finished
            notifyPresenter()
        }
    }

//    MARK: - Animation presented
    private func notifyPresenter() {
        let responce = Game.Response(
            gameState: gameState,
            cards: cards,
            score: score,
            matchedPairs: matchedPairs,
            totalPairs: totalPairs,
            lastSelectedPosition: firstSelectedPosition,
            secondSelectedPosition: secondSelectedPosition
        )

        presenter.presentGame(responce)
    }

    private func isValidePosition(position: MainSceneModel.Position) -> Bool {
        position.row >= 0
        && position.row < cards.count
        && position.column >= 0
        && position.column < cards[position.row].count
    }

    private func isCardMathed(at position: MainSceneModel.Position) -> Bool {
        cards[position.row] [position.column].isMatches
    }

    private func isCardFlipped(position: MainSceneModel.Position) -> Bool {
        cards[position.row] [position.column].isFlipped
    }

    private func flipCard(at position: MainSceneModel.Position) {
        cards[position.row] [position.column].flip()
    }
}
