//
//  PostPhotoCell.swift
//  MoveOn
//
//  Created by 심주미 on 2021/12/27.
//

import UIKit
import PhotosUI

class PostPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageURL:URL?
    
    func loadImage(asset: PHAsset){
        //self.photoImageView.image = nil
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 300*scale, height: 300*scale)
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat //고화질만 받는 옵션
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { image, info in
            self.photoImageView.image = image

        }
    }
}

extension PHAsset {
    func getURL(completion: @escaping ((_ responseURL : URL?) -> Void)) {
        if self.mediaType == .image {
            let options = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) ->  Bool in
                return true
            }
            self.requestContentEditingInput(with: options) { (contentEditingInput: PHContentEditingInput?, info:[AnyHashable : Any]) -> Void in
                completion(contentEditingInput!.fullSizeImageURL as URL?)
            }
        }
    }
}
