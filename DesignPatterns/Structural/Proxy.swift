//
//  Proxy.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

protocol Image {
    func showImage()
}

class ProxyImage {
    private var realImage: Image?
    private let url: String
    
    init(url: String) {
        self.url = url
        print("Image unloaded: \(url)")
    }
}
extension ProxyImage: Image {
    func showImage() {
        if nil == realImage {
            realImage = RealImage(url: url)
        } else {
            print("Image already existed: \(url)")
        }
        
        realImage?.showImage()
    }
}

class RealImage {
    private let url: String
    
    init(url: String) {
        self.url = url
        print("Image loaded: \(url)")
    }
}
extension RealImage: Image {
    func showImage() {
        print("Image showed: \(url)")
    }
}

// PROXY image

// Final class
class Proxy {
    func main() -> Int {
        let proxyImage = ProxyImage(url: "https://gpcoder.com/favicon.ico")
        print("Init proxy image: ")
        
        print("---")
        print("Call real service 1st: ")
        proxyImage.showImage()
        
        print("---")
        print("Call real service 2nd: ")
        proxyImage.showImage()
        
        return 1
    }
}

// PROBLEM
//  + Virtual Proxy : Virtual Proxy tạo ra một đối tượng trung gian mỗi khi có yêu cầu tại thời điểm thực thi ứng dụng, nhờ đó làm tăng hiệu suất của ứng dụng.
//  + Protection Proxy : Phạm vi truy cập của các client khác nhau sẽ khác nhau. Protection proxy sẽ kiểm tra các quyền truy cập của client khi có một dịch vụ được yêu cầu.
//  + Remote Proxy : Client truy cập qua Remote Proxy để chiếu tới một đối tượng được bảo về nằm bên ngoài ứng dụng (trên cùng máy hoặc máy khác).
//  + Monitor Proxy : Monitor Proxy sẽ thiết lập các bảo mật trên đối tượng cần bảo vệ, ngăn không cho client truy cập một số trường quan trọng của đối tượng. Có thể theo dõi, giám sát, ghi log việc truy cập, sử dụng đối tượng.
//  + Firewall Proxy : bảo vệ đối tượng từ chối các yêu cầu xuất xứ từ các client không tín nhiệm.
//  + Cache Proxy : Cung cấp không gian lưu trữ tạm thời cho các kết quả trả về từ đối tượng nào đó, kết quả này sẽ được tái sử dụng cho các client chia sẻ chung một yêu cầu gửi đến. Loại Proxy này hoạt động tương tự như Flyweight Pattern.
//  + Smart Reference Proxy : Là nơi kiểm soát các hoạt động bổ sung mỗi khi đối tượng được tham chiếu.
//  + Synchronization Proxy : Đảm bảo nhiều client có thể truy cập vào cùng một đối tượng mà không gây ra xung đột. Khi một client nào đó chiếm dụng khóa khá lâu khiến cho số lượng các client trong danh sách hàng đợi cứ tăng lên, và do đó hoạt động của hệ thống bị ngừng trệ, có thể dẫn đến hiện tượng “tắc nghẽn”.
//  + Copy-On-Write Proxy : Loại này đảm bảo rằng sẽ không có client nào phải chờ vô thời hạn. Copy-On-Write Proxy là một thiết kế rất phức tạp.

 */
