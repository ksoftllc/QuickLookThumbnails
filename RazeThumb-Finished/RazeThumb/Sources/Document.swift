/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit.UIScreen
import QuickLookThumbnailing

struct Document: Hashable {
  let url: URL

  init(url: URL) {
    self.url = url
  }

  var name: String {
    url.deletingPathExtension().lastPathComponent
  }

  var type: String {
    url.pathExtension
  }
}

// MARK: - Static helper methods
extension Document {
  static let files = [
    Bundle.main.url(forResource: "zombiethumb", withExtension: "png"),
    Bundle.main.url(forResource: "thumbsup", withExtension: "txt"),
    Bundle.main.url(forResource: "humanthumb", withExtension: "pdf")
  ]
  .compactMap { $0 }

  static var documents: [Document] {
    documentsDirectoryContents.map { Document(url: $0) }
  }

  static var documentsDirectoryContents: [URL] {
    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return []
    }

    let urls: [URL]
    do {
      urls = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    } catch {
      fatalError("Couldn't load files from documents directory")
    }

    return urls
  }

  static func copyResourcesToDocuments() {
    files.forEach { url in
      let fileExists = documentsDirectoryContents.contains { $0.lastPathComponent == url.lastPathComponent }

      do {
        if !fileExists {
          let newURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(url.lastPathComponent)
          try FileManager.default.copyItem(at: url, to: newURL)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - QuickLookThumbnailing
extension Document {
  func generateThumbnail(completion: @escaping (UIImage) -> Void) {
    let size = CGSize(width: 150, height: 150)
    let scale = UIScreen.main.scale

    let request = QLThumbnailGenerator.Request(
      fileAt: url,
      size: size,
      scale: scale,
      representationTypes: .all)

    let generator = QLThumbnailGenerator.shared
    generator.generateRepresentations(for: request) { thumbnail, _, error in
      if let thumbnail = thumbnail {
        completion(thumbnail.uiImage)
      } else if let error = error {
        // Handle error
        print("thumbnail error for \(name).\(type) \(error)")
      }
    }
  }
}
