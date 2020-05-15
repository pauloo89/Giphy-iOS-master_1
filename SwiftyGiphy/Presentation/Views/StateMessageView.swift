import UIKit


final class StateMessageView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black // и так по-умолчанию
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubviews([titleLabel, button])
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16) // 16 будет часто встречаться, можно сразу объявить такие константы для всех вьюх
            $0.centerY.equalToSuperview().offset(-100)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16) // .offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}
