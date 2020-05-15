import Foundation
import Nuke
import FLAnimatedImage


extension FLAnimatedImageView {
  // честно говоря, ниче не понял, что тут происходит. слишком много усилий надо прикладывать, чтобы это понять. такое поддерживать никто не будет
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
