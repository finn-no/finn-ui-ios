import Combine

public protocol SuggestShippingService {
    func suggestShipping(forAdId adId: String) async -> SuggestShippingViewModel.SuggestShippingResult
}

@MainActor
public class SuggestShippingViewModel: ObservableObject {
    @Published var state: State

    private let adId: String
    private let service: SuggestShippingService

    public init(
        adId: String,
        suggestViewModel: SuggestViewModel,
        suggestShippingService: SuggestShippingService
    ) {
        self.adId = adId
        self.state = .suggestShipping(suggestViewModel)
        self.service = suggestShippingService
    }

    public func suggestShipping() {
        state = .processing
        Task {
            let result = await service.suggestShipping(forAdId: adId)
            switch result {
            case .success:
                // We don't need to do anything in this case, the caller site
                // will handle the rest.
                break

            case .failure(let errorViewModel):
                state = .error(errorViewModel)
            }
        }
    }
}

public extension SuggestShippingViewModel {
    enum SuggestShippingResult {
        case success
        case failure(ErrorViewModel)
    }
}

public extension SuggestShippingViewModel {
    enum State {
        case suggestShipping(SuggestViewModel)
        case processing
        case error(ErrorViewModel)
    }
}

public protocol SuggestShippingErrorViewModelButtonHandler {
    func didTapButton()
}

public extension SuggestShippingViewModel {
    struct SuggestViewModel {
        let title: String
        let message: String
        let buttonTitle: String

        public init(title: String, message: String, buttonTitle: String) {
            self.title = title
            self.message = message
            self.buttonTitle = buttonTitle
        }
    }

    struct ErrorViewModel {
        let title: String
        let message: String
        let buttonTitle: String

        private let buttonHandler: SuggestShippingErrorViewModelButtonHandler

        public init(title: String, message: String, buttonTitle: String, buttonHandler: SuggestShippingErrorViewModelButtonHandler) {
            self.title = title
            self.message = message
            self.buttonTitle = buttonTitle
            self.buttonHandler = buttonHandler
        }

        public func openInfoURL() {
            buttonHandler.didTapButton()
        }
    }
}
