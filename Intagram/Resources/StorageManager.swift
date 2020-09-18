//
//  StorageManager.swift
//  Intagram
//
//  Created by guntex01 on 9/15/20.
//  Copyright © 2020 guntex01. All rights reserved.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    // MARK: - public
    
    public func upLoadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func dowloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: {url, error in
            guard let url = url , error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
    public enum UserPostType {
        case photo, video
    }
    
    /// Represents a user post
    public struct UserPost {
        let identifier: String
        let postType: UserPostType
        let thumbnailImage: URL
        let postURL: URL // either  video url or full resolution photo
        let caption: String?
        let likeCount: [PostLike]
        let comments: [PostComment]
        let createDate: Date
    }
    
    struct PostLike {
        let username: String
        let postIdentifier: String
    }
    
    struct CommentLike {
        let username: String
        let commentIdentifier: String
    }
    
    struct PostComment {
        let identifier: String
        let username: String
        let text: String
        let createDate: Date
        let likes: [CommentLike]
    }
}
