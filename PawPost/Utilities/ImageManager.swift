//
//  ImageManager.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 10/10/24.
//

import Foundation
import FirebaseStorage

class ImageManager {
    //MARK: Properties
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    //MARK: Public functions
    // functions we call from other places in this app
    func uploadProfileImage(userID: String, image: UIImage) {
        //Get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        // save the image
        uploadImage(path: path, image: image) { _ in }
    }
    
    //MARK: Private functions
    // functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference, image:UIImage, handler: @escaping (_ success: Bool) -> ()){
        
        var compression: CGFloat = 1.0
        let maxFileSize: Int = 240 * 240 // max file size that we want to save
        let maxCompression: CGFloat = 0.05
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting the image data")
            handler(false)
            return
        }
        
        // check max file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
        }
        
        // get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting the image data")
            handler(false)
            return
        }
        
        // get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // save image data to path
        path.putData(finalData, metadata: metadata) { _, error in
            if let error = error {
                // error
                print("Error saving image to path \(error)")
                handler(false)
                return
            } else {
                // success
                print("Success uploading data")
                handler(true)
                return
            }
        }
    }
    
}
