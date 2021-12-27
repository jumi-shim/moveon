//
//  EditPostingViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/18.
//

import UIKit
import PhotosUI

class EditPostingViewController: UIViewController {

    
    var fetchAssets: PHFetchResult<PHAsset>?
    @IBOutlet weak var titleBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var finishBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationItem()
        makePhotoCollectionViewLayout()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        photoCollectionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        photoCollectionView.layer.shadowOpacity = 0.1
        photoCollectionView.layer.masksToBounds = false
        
    }
    func makePhotoCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 300, height: 300)
        photoCollectionView.collectionViewLayout = layout
    }
    
    func makeNavigationItem(){
        let title = UILabel()
        title.text = "글쓰기"
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleBarButtonItem.customView = title
        
        
        let finishLabel = UILabel()
        let shadowLabel = UILabel()
        
        finishLabel.text = "완료"
        finishLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        finishLabel.backgroundColor = UIColor(red: 255/255, green: 174/255, blue: 174/255, alpha: 1)
        finishLabel.frame.size.width = 80
        finishLabel.frame.size.height = 35
        finishLabel.layer.cornerRadius = 35/2
        finishLabel.textAlignment = .center
        finishLabel.clipsToBounds = true
        
        shadowLabel.frame.size.width = 80
        shadowLabel.frame.size.height = 35
        shadowLabel.layer.masksToBounds = false
        shadowLabel.layer.shadowColor = UIColor.black.cgColor
        shadowLabel.layer.shadowOffset = CGSize(width: 2, height: 4)
        shadowLabel.layer.shadowOpacity = 0.07
        shadowLabel.layer.shadowRadius = 1.5
        shadowLabel.addSubview(finishLabel)
        
        finishBarButtonItem.customView = shadowLabel
    }
    @IBAction func closeView(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    func showGallery(){
        let library = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10   //사진 선택 개수 제한
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    func showPhotoAuthorizationDeniedAlert(){
        let alert = UIAlertController(title: "사진첩 접근 권한을 허용해주세요.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else{
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func checkPhotoPermission() {
        let accessLevel: PHAccessLevel = .readWrite
        let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: accessLevel )
        if authorizationStatus == .limited || authorizationStatus == .authorized {
            DispatchQueue.main.async {
                self.showGallery()
            }
        }else if authorizationStatus == .denied {
            DispatchQueue.main.async {
                self.showPhotoAuthorizationDeniedAlert()
            }
        }else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                self.checkPhotoPermission()
            }
        }
    }

}

extension EditPostingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchAssets?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PostPhotoCell
        if let asset = self.fetchAssets?[indexPath.row]{
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
}
extension EditPostingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkPhotoPermission()
    }
}

extension EditPostingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let identifiers = results.map{$0.assetIdentifier ?? ""}
        self.fetchAssets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        if fetchAssets?.count != 0{
            self.photoCollectionView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
