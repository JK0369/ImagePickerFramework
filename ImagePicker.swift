// this required to AlertFramework
// this framework is use when add event listener on image view.
// addition to provide the image picker

// inherit the this class

import UIKit
import AlertFramework

open class ImagePicker:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public var img: UIImageView!
    
    public func RegisterTapOnImageView(imageView view: UIImageView){
        
        self.img = view
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImgView(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func tappedImgView(_ sender: Any) {
        self.selectImg()
    }
    
    private func selectImg() {
        let msg = "Select the image"
        let sheet = UIAlertController(title: nil, message: msg, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let savedAlbum = UIAlertAction(title: "Saved Album", style: .default) { (_) in
            self.selectLibrary(src: .savedPhotosAlbum)
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default){(_) in
            self.selectLibrary(src: .photoLibrary)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default){(_) in
            self.selectLibrary(src: .camera)
        }
        
        sheet.addAction(savedAlbum)
        sheet.addAction(photoLibrary)
        sheet.addAction(camera)
        
        self.present(sheet, animated: false)
    }
    
    private func selectLibrary(src: UIImagePickerController.SourceType) {
        if !UIImagePickerController.isSourceTypeAvailable(src) {
            let alert = Alert()
            alert.alert(vc: self, message: "can't use this file type")
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.img.image = img
        }
        self.dismiss(animated: true)
    }
}
