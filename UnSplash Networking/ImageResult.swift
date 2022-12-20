////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome {
//    let total, totalPages: Int
//    let results: [Result]
//}
//
//// MARK: - Result
//struct Result {
//    let id: String
//    let createdAt: Date
//    let width, height: Int
//    let color, blurHash: String
//    let likes: Int
//    let likedByUser: Bool
//    let resultDescription: String
//    let user: User
//    let currentUserCollections: [Any?]
//    let urls: Urls
//    let links: ResultLinks
//}
//
//// MARK: - ResultLinks
//struct ResultLinks {
//    let linksSelf: String
//    let html, download: String
//}
//
//// MARK: - Urls 
//struct Urls {
//    let raw, full, regular, small: String
//    let thumb: String
//}
//
//// MARK: - User
//struct User {
//    let id, username, name, firstName: String
//    let lastName, instagramUsername, twitterUsername: String
//    let portfolioURL: String
//    let profileImage: ProfileImage
//    let links: UserLinks
//}
//
//// MARK: - UserLinks
//struct UserLinks {
//    let linksSelf: String
//    let html: String
//    let photos, likes: String
//}
//
//// MARK: - ProfileImage
//struct ProfileImage {
//    let small, medium, large: String
//}
