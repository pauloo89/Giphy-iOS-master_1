import Foundation
import Nuke

// и где используется объявление этого интерфейса? нигде кроме AppConfiguringImpl. а смысл тогда?
protocol AppConfiguring {
    func configure()
}


final class AppConfiguringImpl: AppConfiguring {
    func configure() {
        setupNuke()
    }
    
    private func setupNuke() {
        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
    }
}

