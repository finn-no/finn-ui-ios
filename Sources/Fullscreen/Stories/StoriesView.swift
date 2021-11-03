import Foundation
import UIKit
import FinniversKit

public protocol StoriesViewDataSource: AnyObject {
    func storiesView(_ view: StoriesView, loadImageWithPath imagePath: String, imageWidth: CGFloat, completion: @escaping ((UIImage?) -> Void))
}

public protocol StoriesViewDelegate: AnyObject {
    func storiesViewDidFinishStory(_ view: StoriesView)
}

public class StoriesView: UIView {

    // MARK: - Subviews

    private lazy var storyIconImageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = storyIconImageWidth/2
        return imageView
    }()

    private lazy var storyTitleLabel: Label = {
        let label = Label(style: .captionStrong, withAutoLayout: true)
        label.textColor = .milk
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var adTitleLabel: Label = {
        let label = Label(style: .title3Strong, withAutoLayout: true)
        label.textColor = .milk
        return label
    }()

    private lazy var adDetailLabel: Label = {
        let label = Label(style: .detail, withAutoLayout: true)
        label.textColor = .milk
        return label
    }()

    private lazy var progressView: ProgressView = {
        let progressView = ProgressView(withAutoLayout: true)
        progressView.delegate = self
        return progressView
    }()

    // MARK: - Private properties

    private var currentIndex = 0 {
        didSet {
            updateCurrentSlide()
        }
    }

    private var slides = [StorySlideViewModel]()
    private var imageUrls = [String]()
    private var downloadedImages = [String: UIImage?]()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let storyIconImageWidth: CGFloat = 32

    private var currentImageUrl: String? {
        imageUrls[safe: currentIndex]
    }

    // MARK: - Public properties

    public weak var dataSource: StoriesViewDataSource?
    public weak var delegate: StoriesViewDelegate?

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        addSubview(imageView)
        imageView.fillInSuperview()

        addSubview(progressView)
        addSubview(adTitleLabel)
        addSubview(adDetailLabel)
        addSubview(storyTitleLabel)
        addSubview(storyIconImageView)

        tapGestureRecognizer.addTarget(self, action: #selector(handleTap(recognizer:)))
        addGestureRecognizer(tapGestureRecognizer)

        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingS),
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .spacingS),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingS),
            progressView.heightAnchor.constraint(equalToConstant: 3),

            storyIconImageView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            storyIconImageView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: .spacingS),
            storyIconImageView.widthAnchor.constraint(equalToConstant: storyIconImageWidth),
            storyIconImageView.heightAnchor.constraint(equalToConstant: storyIconImageWidth),

            storyTitleLabel.leadingAnchor.constraint(equalTo: storyIconImageView.trailingAnchor, constant: .spacingS),
            storyTitleLabel.centerYAnchor.constraint(equalTo: storyIconImageView.centerYAnchor),
            storyTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: progressView.trailingAnchor),

            adTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingM),
            adTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant:  -.spacingM),
            adTitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.spacingXL),

            adDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingM),
            adDetailLabel.bottomAnchor.constraint(equalTo: adTitleLabel.topAnchor, constant: -.spacingS),
            adDetailLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.spacingM),
        ])
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.addGradients()
    }

    // MARK: - Public methods

    public func configure(
        with slides: [StorySlideViewModel],
        storyTitle: String?,
        storyIconImageUrl: String?
    ) {
        self.slides = slides
        self.imageUrls = slides.map({ $0.imageUrl })

        currentIndex = 0
        progressView.configure(withNumberOfProgresses: slides.count)

        storyTitleLabel.text = storyTitle

        if let storyIconImageUrl = storyIconImageUrl {
            dataSource?.storiesView(self, loadImageWithPath: storyIconImageUrl, imageWidth: storyIconImageWidth, completion: { [weak self] image in
                self?.storyIconImageView.image = image
            })
        }
    }

    public func startStory(durationPerSlideInSeconds: Double = 5) {
        progressView.startAnimating(durationPerSlideInSeconds: durationPerSlideInSeconds)
    }

    // MARK: - Private methods

    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self).x
        if tapLocation > frame.size.width / 2 {
            showNextSlide()
        } else {
            showPreviousSlide()
        }
    }

    private func showNextSlide() {
        guard currentIndex + 1 < slides.count else {
            delegate?.storiesViewDidFinishStory(self)
            return
        }
        currentIndex += 1
    }

    private func showPreviousSlide() {
        currentIndex = max(0, currentIndex - 1)
    }

    private func updateCurrentSlide() {
        guard let slide = slides[safe: currentIndex] else { return }
        progressView.setActiveIndex(currentIndex)

        adTitleLabel.text = slide.title
        adDetailLabel.text = slide.detailText

        if let image = downloadedImages[slide.imageUrl] {
            showImage(image)
        } else {
            imageView.image = nil
            downloadImage(withUrl: slide.imageUrl)
        }

        predownloadNextImageIfNeeded()
    }

    private func predownloadNextImageIfNeeded() {
        guard let imageUrl = imageUrls[safe: currentIndex + 1] else { return }
        downloadImage(withUrl: imageUrl)
    }

    private func downloadImage(withUrl imageUrl: String) {
        guard !downloadedImages.keys.contains(imageUrl) else { return }
        downloadedImages[imageUrl] = nil

        dataSource?.storiesView(self, loadImageWithPath: imageUrl, imageWidth: frame.size.width, completion: { [weak self] image in
            guard let self = self else { return }
            if imageUrl == self.currentImageUrl {
                self.showImage(image)
            } else {
                self.downloadedImages[imageUrl] = image
            }
        })
    }

    private func showImage(_ image: UIImage?) {
        guard let image = image else {
            imageView.image = nil
            return
        }
        let contentMode: UIView.ContentMode = image.isLandscapeOrientation ? .scaleAspectFit : .scaleAspectFill
        imageView.contentMode = contentMode
        imageView.image = image
    }
}

// MARK: - ProgressViewDelegate

extension StoriesView: ProgressViewDelegate {
    func progressViewDidFinishProgress(_ progressView: ProgressView, isLastProgress: Bool) {
        if !isLastProgress {
            currentIndex += 1
        } else {
            delegate?.storiesViewDidFinishStory(self)
        }
    }
}

extension UIImage {
    var isLandscapeOrientation: Bool {
        return size.width > size.height // should square images be treated like landscape?
    }
}

extension UIView {
    func addGradients() {
        guard frame.width > 0 else { return }
        if let sublayers = layer.sublayers, !sublayers.isEmpty {
            return
        }
        addGradient(for: .top)
        addGradient(for: .bottom)
    }

    private enum ShadowEdge {
        case top
        case bottom
    }

    private func addGradient(for shadowEdge: ShadowEdge) {
        let gradientLayer = CAGradientLayer()

        switch shadowEdge {
        case .top:
            let radius: CGFloat = 250
            gradientLayer.opacity = 0.5
            gradientLayer.colors = [UIColor.topGradientColor.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: radius)
        case .bottom:
            let radius: CGFloat = 250
            gradientLayer.opacity = 0.75
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.frame = CGRect(x: 0.0, y: frame.height - radius, width: frame.width, height: radius)
        }

        layer.addSublayer(gradientLayer)
    }
}

private extension UIColor {
    class var topGradientColor: UIColor {
        .dynamicColorIfAvailable(defaultColor: .sardine, darkModeColor: .darkSardine)
    }
}
