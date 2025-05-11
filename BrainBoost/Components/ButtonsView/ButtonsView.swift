import UIKit

final class ButtonsView: UIView {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let easyButton: Button = {
        let button = Button(style: .easyDifficultyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = {
            print("Easy")
        }
        return button
    }()

    private let mediumButton: Button = {
        let button = Button(style: .mediumDifficultyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = {
            print("Medium")
        }
        return button
    }()

    private let hardButton: Button = {
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .buttonsBackground
    }

    private func setupLayouts() {
        addSubview(stackView)

        stackView.addArrangedSubview(easyButton)
        stackView.addArrangedSubview(mediumButton)
        stackView.addArrangedSubview(hardButton)
    }


}

#Preview {
    ButtonsView()
}
