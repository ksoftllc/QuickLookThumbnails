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

#import "ThumbnailProvider.h"

@implementation ThumbnailProvider

- (void)provideThumbnailForFileRequest:(QLFileThumbnailRequest *)request completionHandler:(void (^)(QLThumbnailReply * _Nullable, NSError * _Nullable))handler {
    
    // There are three ways to provide a thumbnail through a QLThumbnailReply. Only one of them should be used.
    
    // First way: Draw the thumbnail into the current context, set up with UIKit's coordinate system.
    handler([QLThumbnailReply replyWithContextSize:request.maximumSize currentContextDrawingBlock:^BOOL {
        // Draw the thumbnail here.
        
        // Return YES if the thumbnail was successfully drawn inside this block.
        return YES;
    }], nil);
    
    /*
    
    // Second way: Draw the thumbnail into a context passed to your block, set up with Core Graphics's coordinate system.
    handler([QLThumbnailReply replyWithContextSize:request.maximumSize drawingBlock:^BOOL(CGContextRef  _Nonnull context) {
        // Draw the thumbnail here.
     
        // Return YES if the thumbnail was successfully drawn inside this block.
        return YES;
    }], nil);
     
    // Third way: Set an image file URL.
    handler([QLThumbnailReply replyWithImageFileURL:[NSBundle.mainBundle URLForResource:@"fileThumbnail" withExtension:@"jpg"]], nil);
    
    */
}

@end
