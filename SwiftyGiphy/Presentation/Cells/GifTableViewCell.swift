import UIKit
import Nuke
import FLAnimatedImage
import SnapKit


protocol GifCellModel {
    var gifUrl: URL { get }
    var userAvatarUrl: URL? { get }
    var userName: String? { get }
    var sizeRatio: Float { get }
}


struct DefaultGifCellModel: GifCellModel {
    let gifUrl: URL
    let userAvatarUrl: URL?
    let userName: String?
    let sizeRatio: Float
}


final class GifTableViewCell: CommonInitTableViewCell {
//  extension NSObject {
//    static var reuseIdentifier: String {
//      return NSStringFromClass(self)
//    }
//  }
  // подходит для любых классов, чтобы в каждой ячейке не копипастить этот ↓ код
    static var reuseId: String {
        return String(describing: GifTableViewCell.self)
    }
    
    private let avatarImageView = UIImageView()
    private let gifImageView = FLAnimatedImageView()
    private let gifActivityIndicator = UIActivityIndicatorView(style: .gray)
    private let avatarActivityIndicator = UIActivityIndicatorView(style: .gray)
    private let userNameLabel = UILabel()
    private let avatarSize: CGFloat = 40
    
    override func setup() {
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        selectionStyle = .none
        accessibilityIdentifier = AccessibilityIds.MainScreen.ResultsTableView.Cell.cell
        
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .black
        userNameLabel.accessibilityIdentifier = AccessibilityIds.MainScreen.ResultsTableView.Cell.userName
        
        avatarImageView.clipsToBounds = true
        avatarImageView.setRounded(radius: avatarSize / 2)
        avatarImageView.accessibilityIdentifier = AccessibilityIds.MainScreen.ResultsTableView.Cell.avatar
        gifImageView.clipsToBounds = true
        gifImageView.setRounded()
        gifImageView.accessibilityIdentifier = AccessibilityIds.MainScreen.ResultsTableView.Cell.gif
    }
    
    private func setupLayout() {
        addSubviews([
            avatarImageView,
            gifImageView,
            userNameLabel
        ])
        
        avatarImageView.addSubview(avatarActivityIndicator)
        gifImageView.addSubview(gifActivityIndicator)
        
        avatarActivityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gifActivityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.height.width.equalTo(avatarSize)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(avatarImageView.snp.centerY)
            $0.left.equalTo(avatarImageView.snp.right).inset(-8)
            $0.right.equalToSuperview().inset(-16)
        }
        
        gifImageView.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).inset(-8)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.nuke_display(image: nil)
        avatarImageView.nuke_display(image: nil)
    }
    
    func configureWith(cellModel: GifCellModel) {
        gifActivityIndicator.startAnimating()
        
        configureAvatarWith(cellModel: cellModel)
        
        setupLayout()
        
        loadImage(
            with: cellModel.gifUrl,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
            into: gifImageView,
            completion: { [weak self] _ in
                self?.gifActivityIndicator.stopAnimating()
            }
        )
    }

  // private func  configureAvatar(with cellModel: GifCellModel) {
    private func configureAvatarWith(cellModel: GifCellModel) {
        avatarActivityIndicator.startAnimating()
        userNameLabel.text = cellModel.userName?.isEmpty ?? true ? "Инкогнито" : cellModel.userName
        
        guard let avatarUrl = cellModel.userAvatarUrl else {
            avatarImageView.image =  #imageLiteral(resourceName: "avatar_placeholder")
            avatarActivityIndicator.stopAnimating()
            return
        }
        
        loadImage(
            with: avatarUrl,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
            into: avatarImageView,
            completion: { [weak self] _ in
                self?.avatarActivityIndicator.stopAnimating()
            }
        )
    }
}
