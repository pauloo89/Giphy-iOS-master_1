import UIKit


final class StateMessageView: UIView {
    let titleLabel = UILabel()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        
        addSubviews([titleLabel, button])
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview().offset(-100)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.centerX.equalToSuperview()
        }
    }
}
