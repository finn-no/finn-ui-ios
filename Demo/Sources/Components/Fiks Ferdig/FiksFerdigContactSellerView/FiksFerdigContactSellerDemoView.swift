import FinniversKit
import FinnUI
import DemoKit

final class FiksFerdigContactSellerDemoView: UIView, Demoable {
    var viewModel: FiksFerdigContactSellerViewModel
    let accordionView: FiksFerdigContactSellerView

    override init(frame: CGRect) {
        self.viewModel = FiksFerdigContactSellerViewModel(
            message: "Hvis du lurer på noe om varen, så send en melding til selger",
            buttonTitle: "Kontakt selger"
        )
        self.accordionView = FiksFerdigContactSellerView(
            viewModel: viewModel,
            withAutoLayout: true
        )

        super.init(frame: frame)

        viewModel.delegate = self
        setup()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        addSubview(accordionView)

        NSLayoutConstraint.activate([
            accordionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .spacingM),
            accordionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .spacingM),
            accordionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.spacingM)
        ])

        accordionView.layoutIfNeeded()
    }
}

extension FiksFerdigContactSellerDemoView: FiksFerdigContactSellerViewModelDelegate {
    func fiksFerdigContactSellerViewModelDidRequestContactSeller() {
        print("🎉 did tap contact seller")
    }
}
