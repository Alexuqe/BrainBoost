import UIKit

final class MainViewController: UIViewController {

    private let scoreView: UIView = {
        let view = ScoreView(frame: .zero)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let difficultyButtons: UIStackView = {
        let view = ButtonsStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        view.addSubview(scoreView)
        view.addSubview(difficultyButtons)

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            scoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            scoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            scoreView.heightAnchor.constraint(equalToConstant: 60),

            difficultyButtons.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 30),
            difficultyButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            difficultyButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

#Preview {
    MainViewController()
}
