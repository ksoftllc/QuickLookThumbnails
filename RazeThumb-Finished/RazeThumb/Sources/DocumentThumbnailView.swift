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

import SwiftUI

struct DocumentThumbnailView: View {
  let document: Document
  @State var thumbnail: UIImage?

  init(for document: Document) {
    self.document = document
//    document.generateThumbnail { thumbnailImage in
//      self.thumbnail = thumbnailImage
//    }
  }

  var body: some View {
    HStack(alignment: .center) {
      Group {
        if let thumbnail = thumbnail {
          Image(uiImage: thumbnail)
            .frame(minWidth: 150, maxWidth: 150, minHeight: 150, alignment: .center)
            .background(Color.gray)
            .cornerRadius(10)
            .padding()
        } else {
          Image(systemName: "doc")
            .font(.system(size: 120))
            .frame(minWidth: 150, maxWidth: 150, minHeight: 150, alignment: .center)
            .background(Color.gray)
            .cornerRadius(10)
            .padding()
        }
      }
      VStack(alignment: .leading) {
        Text("Name: \(document.name)")
        Text("")
        Text("Type: \(document.type)")
      }
      .frame(minWidth: 150, maxWidth: 200, minHeight: 150, alignment: .leading)
    }
  }
}
