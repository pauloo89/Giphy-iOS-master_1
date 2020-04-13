import UIKit


protocol MainViewOutput: class {
    func cellModels() -> [GifCellModel]
    func set(viewInput: MainViewInput)
    func viewDidLoad()
    func didScrollAlmostToEnd()
    func didSearch(text: String)
    func refresh()
}


protocol MainViewInput: class {
    func setErrorView(hidden: Bool)
    func setNoResultsView(hidden: Bool)
    func reloadData()
    func scrollToTop()
}


final class MainViewController: UIViewController {
    private let output: MainViewOutput
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let titleLabel = UILabel()
    private let noResultsView = StateMessageView()
    private let errorView = StateMessageView()
    
    init(output: MainViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad()
        setupLayout()
        setupTableView()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white

        noResultsView.isHidden = true
        noResultsView.button.isHidden = true
        noResultsView.titleLabel.text = "No Results"
        
        errorView.isHidden = true
        errorView.titleLabel.text = "Something went wrong :("
        errorView.button.setTitle("Refresh", for: .normal)
        errorView.button.addTarget(self, action: #selector(onRefreshButtonTapped), for: .touchUpInside)
        
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search GIPHY"
        searchBar.returnKeyType = .done
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.text = "Swifty GIPHY"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GifTableViewCell.self, forCellReuseIdentifier: GifTableViewCell.reuseId)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
    }
    
    private func setupLayout() {
        view.addSubviews([
            titleLabel,
            searchBar,
            tableView,
            noResultsView,
            errorView
        ])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeArea.top).inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        noResultsView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func onRefreshButtonTapped() {
        output.refresh()
    }
    
    private func createCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GifTableViewCell.reuseId,
                                                       for: indexPath)
            as? GifTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureWith(cellModel: output.cellModels()[indexPath.row])
        
        return cell
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.cellModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createCell(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentCell = output.cellModels()[indexPath.row]
        let ratio = CGFloat(currentCell.sizeRatio)
        let width = view.frame.width - 32

        return width * ratio + 48
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentSize.height - scrollView.contentOffset.y
        guard current <= view!.frame.height else {
            return
        }
        
        output.didScrollAlmostToEnd()
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.didSearch(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}


extension MainViewController: MainViewInput {
    func setErrorView(hidden: Bool) {
        errorView.isHidden = hidden
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setNoResultsView(hidden: Bool) {
        noResultsView.isHidden = hidden
    }
    
    func scrollToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }
}
