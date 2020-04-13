import Foundation
import Nuke
import FLAnimatedImage


extension FLAnimatedImageView {
    @objc open override func nuke_display(image: Image?) {
        guard image != nil else {
            animatedImage = nil
            self.image = nil
            return
        }
        
        guard let data = image?.animatedImageData else {
            self.image = image
            return
        }
        
        self.image = image
        
        DispatchQueue.global().async {
            let animatedImage = FLAnimatedImage(animatedGIFData: data)
            DispatchQueue.main.async {
                if self.image === image {
                    self.animatedImage = animatedImage
                }
            }
        }
    }
}
