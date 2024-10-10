//
//  AuthService.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 09/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let DB_BASE = Firestore.firestore()

class AuthService {
   
    // MARK: Properties
    static let instance = AuthService()
    private var REF_USERS = DB_BASE.collection("users")
    
        // MARK: Auth user functions
    
    func loginUserToFirebase(credential: AuthCredential, handler: @escaping(_ providerID: String?, _ isError: Bool, _ isNewUser: Bool?, _ userID: String?) -> ()) {
        // usually the code gets executed and retuns the type as we mention. In such funtions like this we access database and we wait for the response for the database, Instead of normal completion we use escaping closure. Instead of returning we use handler. we can call handler when ever we want instead of immediately like the return function
        
        
        Auth.auth().signIn(with: credential) { result, error in
            
            // checking error
            if error != nil {
                print("Error logging in to firebase")
                handler(nil,true,nil,nil)
                return
            }
            
            // checking provider Id
            guard let providerId = result?.user.uid else {
                print("Error getting provider id")
                handler(nil,true,nil,nil)
                return
            }
            
            self.checkIfUserExistsInDatabase(providerID: providerId) { returnedUserID in
                if let userID = returnedUserID {
                    // user exists, login to app immediately
                    handler(providerId,false,false,userID)
                } else {
                    // user does not exist,continue to onboarding a new user
                    handler(providerId,false,true,nil)
                }
            }
        }
    }
    
    func loginUserToApp(userID: String, handler: @escaping(_ success: Bool) -> ()) {
        
        // Get the users info
        getUserInfo(forUserID: userID) { returnedName, returnedBio in
            if let name = returnedName, let bio = returnedBio {
                // success
                print("Success getting user info while logging in")
                handler(true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    //set the user data into our app
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.set(name, forKey: CurrentUserDefaults.diplayName)
                    UserDefaults.standard.set(bio, forKey: CurrentUserDefaults.bio)
                }
              
            } else {
                // error
                print("error getting user info while logging in")
                handler(false)
            }
        }
    }
    
    func logOutUser(handler: @escaping (_ success: Bool) -> ()){
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error: \(error)")
            handler(false)
        }
        
        handler(true)
        
        //update user defaults
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
            defaultsDictionary.keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping(_ userID: String?) -> ()) {
        
        // set up user document in user collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // upload profile image to storage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        // upload user data to firestore
        let userData: [String: Any] = [
            DatabaseUserField.displayName : name,
            DatabaseUserField.email : email,
            DatabaseUserField.providerID : providerID,
            DatabaseUserField.provider : provider,
            DatabaseUserField.userID: userID,
            DatabaseUserField.bio: "",
            DatabaseUserField.dateCreated : FieldValue.serverTimestamp()
        ]
        
        document.setData(userData) { error in
            if let error = error {
                // error
                print("Error uploading data to user document: \(error)")
                handler(nil)
            } else {
                // success
                handler(userID)
            }
        }
    }
    
    
    private func checkIfUserExistsInDatabase(providerID: String, handler: @escaping(_ existingUserID: String?) -> ()) {
        
        // if a user id is returned, then user does exists in database
        REF_USERS.whereField(DatabaseUserField.providerID, isEqualTo: providerID).getDocuments { querySnapshot, error in
            
            if let snapShot = querySnapshot, snapShot.count > 0, let document = snapShot.documents.first {
                // success
                let existingUserID = document.documentID
                handler(existingUserID)
                return
            } else {
                // error
                handler(nil)
                return
            }
        }
    }
    
    // MARK: Get user functions
    
    func getUserInfo(forUserID userID: String, handler: @escaping (_ name: String?, _ bio: String?) -> ()) {
        REF_USERS.document(userID).getDocument { DocumentSnapshot, error in
            if let document = DocumentSnapshot, let name = document.get(DatabaseUserField.displayName) as? String, let bio = document.get(DatabaseUserField.bio) as? String {
                // success
                print("success getting user info")
                handler(name,bio)
                return
            } else {
                // error
                print("Error getting user info")
                handler(nil,nil)
                return
            }
        }
    }
    
}
