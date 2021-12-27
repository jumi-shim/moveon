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
