import UIKit

final class MainViewController: UIViewController {

    var interactor: MainBussinesLogic?

    private lazy var mainView: MainView = {
        let view = MainView(frame: UIScreen.main.bounds)

        view.onButtonTap = { [weak self] stackIndex, buttonIndex in
            let position = MainSceneModel.Position(row: stackIndex, column: buttonIndex)
            self?.handleCardTap(at: position)
        }

        view.onDifficultyChange = { [weak self] difficulty in
            self?.handleDifficultyChange(difficulty)
        }

        view.onTimerFinished = { [weak self] in
            self?.handleTimerFinished()
        }

        view.onStartButtonTap = { [weak self] in
            self?.handleResumeGame()
        }

        view.onStopButtonTap = { [weak self] in
            self?.handleGamePause()
        }

        return view
    }()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
}

extension MainViewController {

    private func setupInitialState() {
        let request = Game.Request.startGame
        interactor?.handleGame(request)
    }

    private func handleCardTap(at position: MainSceneModel.Position) {
        let request = Game.Request.cardSelected(position: position)
        interactor?.handleGame(request)
    }

    private func handleDifficultyChange(_ difficulty: Selection) {
        mainView.stopTimer()

        let request = Game.Request.startGame
        interactor?.handleGame(request)
    }

    private func handleGamePause() {
        let request = Game.Request.pauseGame
        interactor?.handleGame(request)
    }

    private func handleResumeGame() {
        let request = Game.Request.resumeGame
        interactor?.handleGame(request)
    }

    private func handleTimerFinished() {
        showAlert(message: "Time is Over")
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Game is Over",
            message: message,
            preferredStyle: .alert
        )

        let restartAction = UIAlertAction(
            title: "Restart?",
            style: .default) { [weak self] _ in
                let request = Game.Request.startGame
                self?.interactor?.handleGame(request)
            }
        let cancelAction = UIAlertAction(title: "Cnacel", style: .destructive)

        alert.addAction(restartAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}

extension MainViewController: MainDisplayLogic {
    
    func displayGame(_ viewModel: Game.ViewModel) {
        mainView.updateScore(score: viewModel.score)

        viewModel.cards.enumerated().forEach { rowIndex, row in
            row.enumerated().forEach { columnIndex, card in
                mainView.updateCard(
                    at: card.position,
                    value: card.value,
                    isEnabled: card.isEnabled,
                    isMatched: card.isMatched,
                    shouldAnimate: card.shouldAnimate
                )
            }
        }

        switch viewModel.gameState {
            case .notStarted:
                mainView.resetGame()
                mainView.enableGameButton(isEnabled: false)
            case .inProgress:
                mainView.startTimer()
                mainView.enableGameButton(isEnabled: true)
            case .paused:
                mainView.stopTimer()
                mainView.enableGameButton(isEnabled: false)
            case .finished:
                mainView.stopTimer()
                mainView.enableGameButton(isEnabled: false)
                showAlert(message: "Congratulations! You've found all pairs!")
        }
    }
}

#Preview {
    MainViewController()
}
