import UIKit

final class MainView: UIView {

    var onButtonTap: ((Int, Int) -> Void)?
    var onDifficultyChange: ((Selection) -> Void)?
    var onTimerFinished: (() -> Void)?
    var onStartButtonTap: (() -> Void)?
    var onStopButtonTap: (() -> Void)?

    private var currentPosition: Selection = .easy

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

    private lazy var timerView: TimerView = {
        let timer = TimerView()
        timer.onTimerFinished = { [weak self] in
            self?.onTimerFinished?()
        }

        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
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

    private lazy var startButton: Button = {
        let button = Button(style: .startButton)
        button.onTap = { [weak self] in
            self?.onStartButtonTap?()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stopButton: Button = {
        let button = Button(style: .stopButton)
        button.onTap = { [weak self] in
            self?.onStopButtonTap?()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .main
        switchTime(to: .easy)

        setupLayout()
        setupButtonsStack()
        setupConstraints()
        setupButtonActions()
        huggingPriority()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtonsStack() {
        let stack: [ButtonsStackView] = (0..<4).map { index in
            let stack = ButtonsStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }

        stack.forEach { gameButtonsStack.addArrangedSubview($0) }
    }

    private func setupButtonActions() {
        gameButtonsStack.arrangedSubviews.enumerated().forEach { stackIndex, stack in
            guard let buttonStack = stack as? ButtonsStackView else { return }

            buttonStack.onTapButton = { [weak self] buttonIndex in
                self?.onButtonTap?(stackIndex, buttonIndex)
            }
        }
    }

    private func switchTime(to selection: Selection) {
        currentPosition = selection

        switch selection {
            case .easy:
                timerView.setTimeInterval(50)
            case .medium:
                timerView.setTimeInterval(30)
            case .hard:
                timerView.setTimeInterval(15)
        }
    }

    private func setupLayout() {
        addSubview(scoreView)
        addSubview(segmentedController)
        addSubview(timerView)
        addSubview(gameButtonsBackground)

        gameButtonsBackground.addSubview(gameButtonsStack)
        gameButtonsBackground.addSubview(stopButton)
        gameButtonsBackground.addSubview(startButton)
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

            timerView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 30),
            timerView.centerXAnchor.constraint(equalTo: centerXAnchor),

            gameButtonsBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            gameButtonsBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            gameButtonsBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            gameButtonsBackground.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 30),

            gameButtonsStack.topAnchor.constraint(equalTo: gameButtonsBackground.topAnchor, constant: 20),
            gameButtonsStack.leadingAnchor.constraint(equalTo: gameButtonsBackground.leadingAnchor, constant: 20),
            gameButtonsStack.trailingAnchor.constraint(equalTo: gameButtonsBackground.trailingAnchor, constant: -20),
            gameButtonsStack.bottomAnchor.constraint(equalTo: stopButton.topAnchor, constant: -35),

            stopButton.leadingAnchor.constraint(equalTo: gameButtonsBackground.leadingAnchor, constant: 20),
            stopButton.bottomAnchor.constraint(equalTo: gameButtonsBackground.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stopButton.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -5),
            stopButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),

            startButton.trailingAnchor.constraint(equalTo: gameButtonsBackground.trailingAnchor, constant: -20),
            startButton.bottomAnchor.constraint(equalTo: gameButtonsBackground.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),
        ])
    }

    private func huggingPriority() {
        stopButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        startButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        startButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

extension MainView {
    func updateScore(score: String) {
        scoreView.setTitle = score
    }

    func updateCard(
        at position: MainSceneModel.Position,
        value: Int?,
        isEnabled: Bool,
        isMatched: Bool,
        shouldAnimate: Bool
    ) {
        guard
            let buttonStack = gameButtonsStack.arrangedSubviews[position.row] as? ButtonsStackView,
            let button = buttonStack.arrangedSubviews[position.column] as? Button
        else { return }

        if shouldAnimate {
            animateCard(card: button, value: value, isEnabled: isEnabled, isMatched: isMatched)
        } else {
            button.setTitle(title: value.map(String.init) ?? "")
            button.isEnabled = isEnabled
            button.backgroundColor = isMatched ? .scoreView : .main
        }
    }

    func animateCard(card: Button, value: Int?, isEnabled: Bool, isMatched: Bool) {
        UIView.transition(
            with: card,
            duration: 0.3,
            options: .transitionFlipFromLeft
        ) { [weak self] in
            self?.updateCardWithoutAnimation(
                card,
                value: value,
                isEnabled: isEnabled,
                isMatched: isMatched
            )
        }
    }

    func updateCardWithoutAnimation(_ card: Button, value: Int?, isEnabled: Bool, isMatched: Bool) {
        card.setTitle(title: value.map(String.init) ?? "")
        card.isEnabled = isEnabled
        card.backgroundColor = isMatched ? .scoreView : .main
    }

    func enableGameButton(isEnabled: Bool) {
        gameButtonsStack.arrangedSubviews.forEach { stack in
            guard let buttonStack = stack as? ButtonsStackView else { return }
            buttonStack.isUserInteractionEnabled = isEnabled
        }

        startButton.isEnabled = !isEnabled
        stopButton.isEnabled = isEnabled
    }

    func resetGame() {
        gameButtonsStack.arrangedSubviews.forEach { stack in
            guard let buttonStack = stack as? ButtonsStackView else { return }

            buttonStack.arrangedSubviews.forEach { button in
                guard let button = button as? Button else { return }
                self.updateCardWithoutAnimation(
                    button,
                    value: nil,
                    isEnabled: true,
                    isMatched: false
                )
            }
        }
        stopTimer()
    }

    func startTimer() {
        timerView.startTimer()
    }

    func stopTimer() {
        timerView.stopTimer()
    }
}
