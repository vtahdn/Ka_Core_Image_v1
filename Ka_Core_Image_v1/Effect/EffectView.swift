//
//  EffectView.swift
//  Ka_Core_Image_v1
//
//  Created by Viet Asc on 1/16/19.
//  Copyright © 2019 Viet Asc. All rights reserved.
//

import UIKit

let kSampleImageName = "Vivid warm.png"

class EffectView: UIViewController {
    
    @IBOutlet weak var imgView: ViewFilter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filters = [CIFilter]()
    var defaultImgs = [UIImage]()
    var imageEffect = UIImage()
    
    let filterDescriptions: [(filterName: String, filterDisplayName: String)] = [
        ("CIColorControls", "None"),
        ("CIPhotoEffectMono", "Mono"),
        ("CIPhotoEffectTonal", "Tonal"),
        ("CIPhotoEffectNoir", "Noir"),
        ("CIPhotoEffectFade", "Fade"),
        ("CIPhotoEffectChrome", "Chrome"),
        ("CIPhotoEffectProcess", "Process"),
        ("CIPhotoEffectTransfer", "Transfer"),
        ("CIPhotoEffectInstant", "Instant"),
        ("CIColorControls", "Cl Controls"),
        ("CIColorPosterize", "Cl Posterize"),
        ("CIExposureAdjust", "Exposure Adjust"),
        ("CIGammaAdjust", "Gamma Adjust"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for description in filterDescriptions {
            filters.append(CIFilter(name: description.filterName)!)
            if let img = UIImage(named: description.filterDisplayName) {
                defaultImgs.append(img)
            }
        }
        imageEffect = UIImage(named: kSampleImageName)!
        imgView.image = imageEffect
        
    }
    
    @IBAction func saveImage(_ sender: UIBarButtonItem) {
        
        UIImageWriteToSavedPhotosAlbum(imgView.image!, self, nil, nil)
        
    }
    
    @IBAction func openAlbum(_ sender: UIBarButtonItem) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
        
    }
    
}

extension EffectView: UINavigationControllerDelegate {
    
}

extension EffectView: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage: UIImage = (info[UIImagePickerController.InfoKey.originalImage]) as? UIImage {
            
            imgView.image = pickedImage
            imageEffect = pickedImage
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension EffectView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filterDescriptions.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoEffectCollectionCell
        if indexPath.item < 9 {
            cell.filteredImageView.image = defaultImgs[indexPath.item]
        } else {
            cell.filteredImageView.image = UIImage(named: "Vivid warm")
        }
        cell.filteredImageView.contentMode = .scaleAspectFill
        cell.filter = filters[indexPath.item]
        cell.filterNameLabel.text = filterDescriptions[indexPath.item].filterDisplayName
        return cell
        
    }
    
}

extension EffectView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < 9 {
            
            let tempCIImage = CIImage(image: imageEffect)
            filters[indexPath.item].setValue(tempCIImage, forKey: kCIInputImageKey)
            let uiTemp = imgView.editedImage(filters[indexPath.item])
            imgView.image = uiTemp
            
        } else {
            
            let mapViewControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "FilterView") as? FilterView
            mapViewControllerObject?.filter = filters[indexPath.item]
            mapViewControllerObject?.image = imgView.image
            self.navigationController?.pushViewController(mapViewControllerObject!, animated: true)
            
        }
        
    }
    
}

extension EffectView: UICollectionViewDelegateFlowLayout {
    
}
