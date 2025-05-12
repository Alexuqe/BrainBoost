import UIKit

final class ScoreView: UIView {

    var setTitle: String = "Score"  {
        willSet {
            scoreLabel.text = newValue
        }
    }

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = Font.heading.font
        label.textColor = .white
        label.text = "Score"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .scoreView
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(scoreLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

#Preview {
    ScoreView()
}
