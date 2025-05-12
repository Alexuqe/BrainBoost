import UIKit

final class Button: UIButton {

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.7 : self.alphaWhenTouch
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    var onTap: (() -> Void)?

    private let style: ButtonsStyle

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()

    private let label = UILabel()

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()

    private var alphaWhenTouch: CGFloat {
        isEnabled ? 1.0 : 0.7
    }

    init(style: ButtonsStyle = .easyDifficultyButton) {
        self.style = style
        super.init(frame: .zero)

        setupLayout()
        setupButton()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(title: String) {
        let attribute: [NSAttributedString.Key : Any] = [
            .font: Font.caption.font,
            .foregroundColor: UIColor.white
        ]

        label.attributedText = NSAttributedString(string: title, attributes: attribute)
    }

    func setTextColor(_ color: UIColor) {
        label.textColor = color
    }

    func setImage(imageView: UIImage?) {
        if let imageView  {
            image.image = imageView
            image.tintColor = style.imageTintColor
        }
    }

    private func setupButton() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 15
        
        if let title = style.title {
            setTitle(title: title)
        }

        if let image = style.image {
            setImage(imageView: image)
        }

        addAction(UIAction { [weak self] _ in self?.onTap?() }, for: .touchUpInside)
    }

    private func setupLayout() {
        addSubview(stackView)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(image)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            heightAnchor.constraint(equalToConstant: 45),

            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func updateAppearance() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        alpha = alphaWhenTouch
    }
}
