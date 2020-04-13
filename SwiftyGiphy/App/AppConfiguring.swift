import Foundation
import Nuke


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

