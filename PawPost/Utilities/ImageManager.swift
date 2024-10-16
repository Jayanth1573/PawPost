//
//  ImageManager.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 10/10/24.
//

import Foundation
import FirebaseStorage

let imageCache = NSCache<AnyObject,UIImage>()

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
        // multi-threading
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { _ in }
        }
        
    }
    
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ success:Bool) -> ()) {
        //Get the path where we will save the image
        let path = getPostImagePath(postID: postID)
        
        // save the image
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { success in
                // the changes should return to main thread
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }
        
    }
    
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()){
        // get the path where image is saved
        
        let path = getProfileImagePath(userID: userID)
        
        // download image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { returnedImage in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
    }
    
    
    func downloadPostImage(postID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        // get path where image is saved
        let path = getPostImagePath(postID: postID)
        
        // download image from path
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { returnedImage in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }
        
    }
    
    //MARK: Private functions
    // functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "posts/\(postID)/1"
        let storagePath = REF_STOR.reference(withPath: postPath)
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
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) -> ()){
        
        if let cachedImage = imageCache.object(forKey: path) {
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { returnedImageData, error in
                if let data = returnedImageData, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("Error getting data from path for image")
                    handler(nil)
                    return
                }
            }
        }
        
    }
    
}
