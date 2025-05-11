import UIKit

final class ButtonsStackView: UIStackView {

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var easyButton: Button = {
        let button = Button(style: .easyDifficultyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = {
            print("Easy")
        }
        return button
    }()

    private lazy var mediumButton: Button = {
        let button = Button(style: .mediumDifficultyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = {
            print("Medium")
        }
        return button
    }()

    private lazy var hardButton: Button = {
        let button = Button(style: .hardDifficultyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = {
            print("Hard")
        }
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupLayouts()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        axis = .horizontal
        spacing = 16
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayouts() {
        addArrangedSubview(easyButton)
        addArrangedSubview(mediumButton)
        addArrangedSubview(hardButton)
    }
}
