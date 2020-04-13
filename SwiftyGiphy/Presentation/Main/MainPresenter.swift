import Foundation


final class MainPresenter {
    private weak var viewInput: MainViewInput?
    private let service: GiphyService
    private var gifDataArray: [GifData] = []
    private var searchText: String?
    
    private var offset = 0
    private var limit = Constants.queryDataLimit
    private var didSearch = false
    private var isLoading = false
    
    private var isSearching: Bool {
        return searchText != nil
    }
    
    init(service: GiphyService) {
        self.service = service
    }
    
    private func loadTrends() {
        guard !isLoading else {
            return
        }
        
        if didSearch {
            offset = 0
        }
        
        isLoading = true
        
        service.getTrends(offset: offset) { [weak self] result in
            do {
                let downloadedData = try result.get()
                self?.handleDownloadedTrends(data: downloadedData)
            } catch {
                self?.handle(error: error)
            }
        }
    }
    
    private func loadSearch(text: String) {
        service.search(query: text, offset: offset, completion: { [weak self] result in
            do {
                let downloadedData = try result.get()
                self?.handleDownloadedSearch(data: downloadedData, searchText: text)
            } catch {
                self?.handle(error: error)
            }
        })
    }
    
    private func handle(error: Error) {
        viewInput?.setErrorView(hidden: false)
        isLoading = false
    }
    
    private func handleDownloadedTrends(data: [GifData]) {
        viewInput?.setNoResultsView(hidden: true)
        
        if didSearch {
            reload(data: data)
            didSearch = false
        } else {
            add(data: data)
        }
        
        handleFinishDownloading()
    }
    
    private func handleDownloadedSearch(data: [GifData], searchText: String) {
        viewInput?.setNoResultsView(hidden: true)
        
        guard !data.isEmpty else {
            isLoading = false
            viewInput?.setNoResultsView(hidden: false)
            return
        }
        
        if isSearching, self.searchText == searchText {
            add(data: data)
        } else {
            reload(data: data)
        }
        
        handleFinishDownloading()
        
        self.searchText = searchText
    }
    
    private func reload(data: [GifData]) {
        gifDataArray = data
        viewInput?.reloadData()
        viewInput?.scrollToTop()
    }
    
    private func add(data: [GifData]) {
        gifDataArray.append(contentsOf: data)
        viewInput?.reloadData()
    }
    
    private func handleFinishDownloading() {
        viewInput?.setErrorView(hidden: true)
        isLoading = false
        offset += limit
    }
}


extension MainPresenter: MainViewOutput {
    func set(loading: Bool) {
        isLoading = loading
    }
    
    func refresh() {
        loadTrends()
    }
    
    func didSearch(text: String) {
        guard !isLoading else {
            return
        }
        
        if !didSearch {
            offset = 0
        }
        
        didSearch = true
        isLoading = true
        
        guard !text.isEmpty else {
            isLoading = false
            searchText = nil
            loadTrends()
            return
        }
        
        loadSearch(text: text)
    }
    
    func cellModels() -> [GifCellModel] {
        return gifDataArray.map({ $0.asGifCellModel() })
    }
    
    func set(viewInput: MainViewInput) {
        self.viewInput = viewInput
    }
    
    func viewDidLoad() {
        loadTrends()
    }
    
    func didScrollAlmostToEnd() {
        if isSearching {
            didSearch(text: searchText ?? "")
        } else {
            loadTrends()
        }
    }
}


extension GifData {
    func asGifCellModel() -> GifCellModel {
        let height = Float(images.downsizedLarge.height) ?? 0
        let width = Float(images.downsizedLarge.width) ?? 0
        
        let ratio = height / width
        
        guard let userAvatarUrl = user?.avatarUrl else {
            return DefaultGifCellModel(gifUrl: images.downsizedLarge.url,
                                       userAvatarUrl: nil,
                                       userName: user?.username,
                                       sizeRatio: ratio)
        }
        
        return DefaultGifCellModel(gifUrl: images.downsizedLarge.url,
                                   userAvatarUrl: URL(string: userAvatarUrl),
                                   userName: user?.username,
                                   sizeRatio: ratio)
    }
}
