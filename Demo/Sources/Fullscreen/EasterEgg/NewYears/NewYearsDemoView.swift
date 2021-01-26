//
//  Copyright © 2018 FINN AS. All rights reserved.
//

import FinniversKit
import FinnUI

class NewYearsDemoView: UIView {
    private lazy var label: Label = {
        let label = Label(style: .title2)
        label.text = "Tap to start animation"
        label.textColor = .textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var newYearsView: NewYearsView = {
        let view = NewYearsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewYearsDemoView {
    @objc func handleTap() {
        newYearsView.isHidden = false
        newYearsView.startAnimation(duration: 10.0)
    }

    func setup() {
        addSubview(label)
        addSubview(newYearsView)
        newYearsView.fillInSuperview()
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.spacingXL)
        ])
    }
}
