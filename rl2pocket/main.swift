import Foundation
import Cocoa

func putPocket(readingList: [[String: AnyObject]]){
    let urls = readingList.map({ (item) -> String in
        item["URLString"] as String
    })
    
    let body = "\n".join(urls).stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    let url = "mailto:add@getpocket.com?subject=rl2pocket&body=\(body)"
    NSWorkspace.sharedWorkspace().openURL(NSURL(string: url)!)
    
    println("Sending... \(urls.count) urls")
}

if let plist = NSDictionary(contentsOfFile: NSHomeDirectory()+"/Library/Safari/Bookmarks.plist") {
    let bookmarks = plist["Children"] as [AnyObject]
    if let readingList = bookmarks.filter({$0["Title"] as String? == "com.apple.ReadingList"}).first?["Children"] as? [[String: AnyObject]] {
        putPocket(readingList)
    }
    
    println("done")
}