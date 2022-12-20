//
//  NetworkManager.swift
//  UnSplash Networking
//
//  Created by guhan-pt6208 on 15/12/22.
//

import Foundation

class NetworkNanager: NSObject   {
    
    var completion: ((Data?, Error?) -> Void)?
    
    var images: [Meme]? = nil
    
    func getMovie() {
        
        let urlString = "https://api.imgflip.com/get_memes"
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        
        urlRequest.httpMethod = "GET"
        //        urlRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print("Error ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Not a good response")
                return
            }
            
            guard (200 ... 299).contains(response.statusCode) else {
                print("Status not Ok")
                return
            }
            
            guard let data = data else {
                print("Bad Data")
                return
            }
            
            if error == nil {
                do {
                    let objResult = try JSONDecoder().decode(MemeResult.self, from: data)
                    //                    let result = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    self.images = objResult.data.memes
                    
                    
                    
                    //                    images?.memes = k
                } catch let e {
                    print(e)
                    
                }
            }
        }
        
        task.resume()
    }
    
    func downlaodImage(completion: @escaping (Data?, Error?) -> (Void)) {
        
        guard let imageUrlString = images?.randomElement()?.url else {
            print("Image URL not found")
            return
        }
        
        guard let imageUrl = URL(string: imageUrlString) else {
            print("Not a valid URL")
            return
        }
        
        var urlRequest = URLRequest(url: imageUrl)
        
        urlRequest.httpMethod = "GET"
        //        urlRequest.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: urlRequest)
        task.resume()
        print("Commencing Downlaod")
        
        self.completion = completion
        
        //        let task = session.downloadTask(with: urlRequest) { localUrl, response, error in
        //
        //            if let error = error {
        //                print("Error ", error)
        //                return
        //            }
        //
        //            guard let response = response as? HTTPURLResponse else {
        //                print("Not a good response")
        //                return
        //            }
        //
        //            guard (200 ... 299).contains(response.statusCode) else {
        //                print("Status not Ok")
        //                return
        //            }
        //
        //            guard let localUrl = localUrl else {
        //                print("Bad Data")
        //                return
        //            }
        //
        //            do {
        //                let image = try Data(contentsOf: localUrl)
        //
        //                DispatchQueue.main.async {
        //                    //                    self.imageView.image = UIImage(data: image)
        //                    completion(image, nil)
        //                }
        //
        //            } catch let e {
        //                print(e)
        //            }
        //        }
        //        task.resume()
        //    }
        
    }
    
    func uploadImage() {
        let url = URL(string: "https://content.dropboxapi.com/2/files/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the authorization header
        let accessToken = "sl.BVSW32eduwtaAJksTvUvXE5CqOwnyIQc_3L5i7f1_L_mzULoIuHJUUb0HqCxtxyk38TQWcIn1KeyDgb0sWQ3xB6YUMhCK4C-lHWmTacu8rPEwJmHRHcUMzowZEOC2fkUh0T7dFKHKYAe"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Set the Dropbox-API-Arg header
        let apiArg = "{\"autorename\":true,\"mode\":\"add\",\"mute\":false,\"path\":\"/Homework/math/next.png\",\"strict_conflict\":false}"
        request.setValue(apiArg, forHTTPHeaderField: "Dropbox-API-Arg")
        
        
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("another.jpg")
        
//        print(fileURL)
        do {
            let fileData = try Data(contentsOf: fileURL)
            
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            let task = session.uploadTask(with: request, from: fileData){ data, response, error in
                
                if let error = error {
                    print("Error ", error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Not a good response")
                    return
                }
                
                if !(200 ... 299).contains(response.statusCode) {
                    print("Status not Okkk")
                    print(response.statusCode)
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                } catch {
                    print(error)
                }
                
            }
            task.resume()
            print("Start Upload ")
        } catch {
            print("error")
        }
    }
}

extension NetworkNanager: URLSessionDownloadDelegate, URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let completion = completion {
            DispatchQueue.main.async {
                do {
                    let image = try Data(contentsOf: location)
                    
                    
                    completion(image, nil)
                    
                } catch {
                    completion(nil, error)
                    //print(error)
                }
            }
        } else {
            print("Completion is nil")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
               let downloadProgress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//               print("\(floor(downloadProgress * 100))%")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        print("\(floor(uploadProgress * 100))%")
    }
}
