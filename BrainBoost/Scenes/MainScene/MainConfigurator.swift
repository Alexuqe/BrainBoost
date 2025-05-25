import UIKit

enum MainConfigurator {
    static func configure() -> UIViewController {
        let presenter = MainPresenter()
        let cardGenerator = CardGenerator()
        let scoreCalculator = ScoreCalcualtor()
        let viewController = MainViewController()

        let interactor = MainSceneInterator(
            presenter: presenter,
            cardGenerator: cardGenerator,
            scoreCalculator: scoreCalculator
        )

        viewController.interactor = interactor
        presenter.viewController = viewController

        return viewController
    }
}
