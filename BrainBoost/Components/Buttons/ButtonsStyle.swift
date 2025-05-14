import UIKit

struct ButtonsStyle {
    let title: String?
    let image: UIImage?
    let icon: UIImage?

    let backgroundColor: UIColor
    let disabledBackgroundColor: UIColor
    let textColor: UIColor?
    let imageTintColor: UIColor?
    let font: UIFont?
    let iconPosition: Button.IconPosition?
}

extension ButtonsStyle {

    static let easyDifficultyButton = ButtonsStyle(
        title: "Easy",
        image: nil,
        icon: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .black,
        imageTintColor: nil,
        font: Font.caption.font,
        iconPosition: nil
    )

    static let mediumDifficultyButton = ButtonsStyle(
        title: "Medium",
        image: nil,
        icon: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .white,
        imageTintColor: nil,
        font: Font.caption.font,
        iconPosition: nil
    )

    static let hardDifficultyButton = ButtonsStyle(
        title: "Hard",
        image: nil,
        icon: nil,
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.5),
        textColor: .white,
        imageTintColor: nil,
        font: Font.caption.font,
        iconPosition: nil
    )

    static let numbersButton = ButtonsStyle(
        title: "1",
        image: nil,
        icon: nil,
        backgroundColor: .main,
        disabledBackgroundColor: .main.withAlphaComponent(0.7),
        textColor: .white,
        imageTintColor: nil,
        font: Font.number.font,
        iconPosition: nil
    )

    static let imagesButton = ButtonsStyle(
        title: nil,
        image: UIImage(),
        icon: nil,
        backgroundColor: .main,
        disabledBackgroundColor: .main.withAlphaComponent(0.7),
        textColor: .clear,
        imageTintColor: .white,
        font: nil,
        iconPosition: nil
    )

    static let startButton = ButtonsStyle(
        title: "Start",
        image: nil,
        icon: UIImage(systemName: "play.fill"),
        backgroundColor: .scoreView,
        disabledBackgroundColor: .scoreView.withAlphaComponent(0.7),
        textColor: .white,
        imageTintColor: .white,
        font: Font.caption.font,
        iconPosition: .left
    )

    static let stopButton = ButtonsStyle(
        title: "Stop",
        image: nil,
        icon: UIImage(systemName: "stop.fill"),
        backgroundColor: .secondaryView,
        disabledBackgroundColor: .secondaryView.withAlphaComponent(0.7),
        textColor: .white,
        imageTintColor: .white,
        font: Font.caption.font,
        iconPosition: .left
    )
}
