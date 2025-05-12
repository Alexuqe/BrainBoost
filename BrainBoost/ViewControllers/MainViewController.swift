import UIKit

final class MainViewController: UIViewController {

    private var currentPosition: DifficultySegmented.Selection = .easy

    private lazy var scoreView: ScoreView = {
        let view = ScoreView(frame: .zero)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var segmentedController: DifficultySegmented = {
        let segmentedControl = DifficultySegmented()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.toggleTimer = { [weak self] selection in
            self?.switchTime(to: selection)
            print(selection)
        }
        return segmentedControl
    }()

    private let gameButtonsBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonsBackground
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main
        switchTime(to: .easy)

        setupLayout()
        setupConstraints()
    }

    private func switchTime(to selection: DifficultySegmented.Selection) {
        currentPosition = selection
        
        switch selection {
            case .easy:
                scoreView.setTitle = "50"
            case .medium:
                scoreView.setTitle = "30"
            case .hard:
                scoreView.setTitle = "15"
        }
    }

    private func setupLayout() {
        view.addSubview(scoreView)
        view.addSubview(segmentedController)
        view.addSubview(gameButtonsBackground)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            scoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            scoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            scoreView.heightAnchor.constraint(equalToConstant: 60),

            segmentedController.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 30),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            gameButtonsBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameButtonsBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameButtonsBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gameButtonsBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
}

#Preview {
    MainViewController()
}
