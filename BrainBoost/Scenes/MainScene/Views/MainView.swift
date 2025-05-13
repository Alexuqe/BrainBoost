import UIKit

final class MainView: UIView {

    var onButtonTap: ((Int, Int) -> Void)?
    var onDifficultyChange: ((DifficultySegmented.Selection) -> Void)?

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
            self?.onDifficultyChange?(selection)
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

    private let gameButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .main
        switchTime(to: .easy)

        setupLayout()
        setupButtonsStack()
        setupConstraints()
        setupButtonActions()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButtonActions() {
        gameButtonsStack.arrangedSubviews.enumerated().forEach { stackIndex, stack in
            (stack as? ButtonsStackView)?.onTapButton = { [weak self] buttonIndex in
                self?.onButtonTap?(stackIndex, buttonIndex)
            }
        }
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
        addSubview(scoreView)
        addSubview(segmentedController)
        addSubview(gameButtonsBackground)

        gameButtonsBackground.addSubview(gameButtonsStack)
    }

    private func setupButtonsStack() {
        let stack: [ButtonsStackView] = (0..<3).map { index in
            let stack = ButtonsStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }

        stack.forEach { gameButtonsStack.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            scoreView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            scoreView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            scoreView.heightAnchor.constraint(equalToConstant: 50),

            segmentedController.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 30),
            segmentedController.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentedController.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            gameButtonsBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            gameButtonsBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            gameButtonsBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            gameButtonsBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),

            gameButtonsStack.topAnchor.constraint(equalTo: gameButtonsBackground.topAnchor, constant: 20),
            gameButtonsStack.leadingAnchor.constraint(equalTo: gameButtonsBackground.leadingAnchor, constant: 20),
            gameButtonsStack.trailingAnchor.constraint(equalTo: gameButtonsBackground.trailingAnchor, constant: -20),
            gameButtonsStack.bottomAnchor.constraint(equalTo: gameButtonsBackground.bottomAnchor, constant: -200),
        ])
    }
}

#Preview {
    MainView()
}
