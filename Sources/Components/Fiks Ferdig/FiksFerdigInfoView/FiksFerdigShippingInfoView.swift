import Combine
import FinniversKit
import UIKit

public final class FiksFerdigShippingInfoView: FiksFerdigAccordionView {
    private let viewModel: FiksFerdigShippingInfoViewModel

    private let cellsContainerStackView = UIStackView(axis: .vertical, spacing: .spacingM)

    private lazy var separatorStackView: UIStackView = {
        let separatorStackView = UIStackView(axis: .horizontal)
        separatorStackView.directionalLayoutMargins = .init(
            top: .zero,
            leading: .spacingM + 24 + .spacingM,
            bottom: .zero,
            trailing: .zero
        )
        separatorStackView.isLayoutMarginsRelativeArrangement = true
        return separatorStackView
    }()

    public init(viewModel: FiksFerdigShippingInfoViewModel, withAutoLayout: Bool = false) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel.headerViewModel, withAutolayout: withAutoLayout)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        cellsContainerStackView.alignment = .leading
        
        for provider in viewModel.providers {
            cellsContainerStackView.addArrangedSubview(
                FiksFerdigShippingInfoCell(viewModel: .init(
                    provider: provider.provider,
                    providerName: provider.providerName,
                    message: provider.message
                ))
            )
        }

        addViewToContentView(cellsContainerStackView)
    }
}

private extension Button.Style {
    static var fiksFerdigAccordionButtonStyle: Button.Style {
        .flat
        .overrideStyle(normalFont: .captionStrong)
    }
}
