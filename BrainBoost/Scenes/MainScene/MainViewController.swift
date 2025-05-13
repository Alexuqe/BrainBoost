import UIKit

final class MainViewController: UIViewController {

    private lazy var mainView: MainView = {
        let view = MainView(frame: UIScreen.main.bounds)

        view.onButtonTap = { [weak self] stackIndex, buttonIndex in
            self?.handleButtonTap(stackIndex: stackIndex, buttonIndex: buttonIndex)
        }

        view.onDifficultyChange = { [weak self] difficulty in
            self?.handleDifficultyChange(difficulty)
        }

        return view
    }()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func handleButtonTap(stackIndex: Int, buttonIndex: Int) {
        print("Нажата кнопка \(buttonIndex + 1) в стеке \(stackIndex + 1)")
    }

    private func handleDifficultyChange(_ difficulty: DifficultySegmented.Selection) {
        print("Изменена сложность на \(difficulty)")
    }
}

#Preview {
    MainViewController()
}
