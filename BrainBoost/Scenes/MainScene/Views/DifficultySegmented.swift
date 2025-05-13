import UIKit

final class DifficultySegmented: UIView {

    enum Selection {
        case easy
        case medium
        case hard
    }

    var toggleTimer: ((Selection) -> Void)?

    private let viewHeight: CGFloat = 70
    private var selectedLeadingConstraints: NSLayoutConstraint?
    private var selectedTrailingConstraints: NSLayoutConstraint?

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var easyButton: Button = {
        let button = Button(style: .easyDifficultyButton)
        button.onTap = { [unowned self] in
            selectDifficulty(.easy)
        }
        return button
    }()

    private lazy var mediumButton: Button = {
        let button = Button(style: .mediumDifficultyButton)
        button.onTap = { [unowned self] in
            selectDifficulty(.medium)
        }
        return button
    }()

    private lazy var hardButton: Button = {
        let button = Button(style: .hardDifficultyButton)
        button.onTap = {[unowned self] in
            selectDifficulty(.hard)
        }
        return button
    }()

    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .scoreView
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .timerView
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false

        setupLayouts()
        setupConstraints()
        setupInitialSection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func selectDifficulty(_ position: Selection) {
        updateSelectedPosition(position: position)
        toggleTimer?(position)
    }

    private func setupLayouts() {
        addSubview(selectedView)
        addSubview(stackView)

        stackView.addArrangedSubview(easyButton)
        stackView.addArrangedSubview(mediumButton)
        stackView.addArrangedSubview(hardButton)
    }

    private func setupInitialSection() {
        updateSelectedPosition(position: .easy)
    }

    private func updateSelectedPosition(position: Selection) {
        let selectedButton: Button
        let unselectedButton: [Button]

        switch position {
            case .easy:
                selectedButton = easyButton
                unselectedButton = [mediumButton, hardButton]
            case .medium:
                selectedButton = mediumButton
                unselectedButton = [easyButton, hardButton]
            case .hard:
                selectedButton = hardButton
                unselectedButton = [easyButton, mediumButton]
        }

        selectedLeadingConstraints?.constant = selectedButton.frame.origin.x - easyButton.frame.origin.x - 5
        selectedTrailingConstraints?.constant = selectedButton.frame.origin.x + easyButton.frame.origin.x + 5

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut
        ) {
            self.layoutIfNeeded()

            selectedButton.setTextColor(.timerView)
            selectedButton.backgroundColor = .scoreView

            unselectedButton.forEach { button in
                button.setTextColor(.white)
                button.backgroundColor = .secondaryView
            }
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -5),
            selectedView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5)
        ])

        selectedLeadingConstraints = selectedView.leadingAnchor.constraint(
            equalTo: easyButton.leadingAnchor,
            constant: -10
        )
        selectedTrailingConstraints = selectedView.trailingAnchor.constraint(
            equalTo: easyButton.trailingAnchor,
            constant: 10
        )

        selectedLeadingConstraints?.isActive = true
        selectedTrailingConstraints?.isActive = true
    }
}


#Preview {
    DifficultySegmented()
}
