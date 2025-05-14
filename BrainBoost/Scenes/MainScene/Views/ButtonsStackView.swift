import UIKit

final class ButtonsStackView: UIStackView {

    var onTapButton: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        addButtons()
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

    private func addButtons() {
        let buttons: [Button] = (0..<3).map { index in
            let button = Button(style: .numbersButton)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.onTap = {
                self.onTapButton?(index)
            }

            return button
        }

        buttons.forEach { addArrangedSubview($0) }
    }
}
