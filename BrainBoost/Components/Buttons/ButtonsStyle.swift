import UIKit

struct ButtonsStyle {
    let title: String?
    let image: UIImage?

    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor?
    let imageTintColor: UIColor?
}

extension ButtonsStyle {

    static let easyDifficultyButton = ButtonsStyle(
        title: "Easy",
        image: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .white,
        imageTintColor: nil
    )

    static let mediumDifficultyButton = ButtonsStyle(
        title: "Medium",
        image: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .white,
        imageTintColor: nil
    )

    static let hardDifficultyButton = ButtonsStyle(
        title: "Hard",
        image: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .white,
        imageTintColor: nil
    )

    static let numbersButton = ButtonsStyle(
        title: "1",
        image: nil,
        backgroundColor: .main,
        disabledBackgroundColor: .main.withAlphaComponent(0.7),
        textColor: .white,
        imageTintColor: nil
    )

    static let imagesButton = ButtonsStyle(
        title: nil,
        image: UIImage(),
        backgroundColor: .main,
        disabledBackgroundColor: .main.withAlphaComponent(0.7),
        textColor: nil,
        imageTintColor: .white
    )
}
