import AVFoundation
import UIKit

final class TimerView: UIView {

    var timeInterval: Double = 15.0 {
        didSet {
            time.text = String(format: "%.0f", timeInterval)
        }
    }

    var onTimerFinished: (() -> Void)?

    private var timer: Timer?
    private var isTimerRunning = false

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "timer")
        image.contentMode = .scaleAspectFit
        image.tintColor = .secondaryView
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time:"
        label.textAlignment = .left
        label.font = Font.mediumHeading.font
        label.textColor = .secondaryView
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var time: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.font = Font.heading.font
        label.textColor = .buttonsBackground
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .timerView
        layer.cornerRadius = 20

        setupLayout()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTimeInterval(_ seconds: Double) {
        timeInterval = seconds
    }

    func startTimer() {
        guard !isTimerRunning else { return }

        isTimerRunning = true
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerTapped),
            userInfo: nil,
            repeats: true
        )
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }

    @objc private func timerTapped() {
        timeInterval -= 1
        
        if timeInterval <= 0 {
            stopTimer()
            onTimerFinished?()
        }
    }

    private func setupLayout() {
        addSubview(stack)
        addSubview(time)

        stack.addArrangedSubview(image)
        stack.addArrangedSubview(timeLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: time.leadingAnchor, constant: -20),
            image.widthAnchor.constraint(equalToConstant: 40),

            time.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            time.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            time.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
