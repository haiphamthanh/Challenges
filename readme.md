* Design patterns: Là tập hợp các biểu mẫu, mô hình, template ứng dụng các đặc tính của hướng đối tượng, giúp cho việc ứng dụng hướng đối tượng trở nên hiệu quả hơn.

* Các nhóm patterns:
 -> Nhóm khởi tạo(creation): Nhiệm vụ khởi tạo đối tượng. (có quản lý)
 -> Nhóm cấu trúc(structure): Nhiệm vụ thiết lập liên kết giữa các đối tượng. (cấu trúc rõ ràng)
 -> Nhóm hành vi(behavior): Nhiệm vụ xây dựng hành vi cho đối tượng. (thống nhất hành vi)

* Nhóm khởi tạo:
 -> Singleton: Chỉ tạo ra một đối tượng trong suốt thời gian sống của app, thống nhất dữ liệu chia sẽ.
 -> Factory: Quản lý việc khởi tạo đối tượng, ẩn đi các logic khởi tạo.
 -> Abstract factory: Tổng hợp nhiều mẫu factory, tăng sự lựa chọn.
 -> Builder: Việc khởi tạo đối tượng với nhiều thông tin rất mất thời gian -> builder sinh ra -> chỉ cần cung cấp thông tin require và xây dựng giá trị mặc định cho các thông tin còn lại -> Giảm độ phức tạp thủ tục khởi tạo.
 -> Prototype: Tạo ra nhiều bản sao từ một đối tượng mẫu.
 -> ObjectPool: Quản lý việc tạo mới, tái sử dụng lại các đối tượng đã khởi tạo.

* Nhóm cấu trúc:
 -> Adapter: Xây dựng lớp trung gian(adapter) giúp cho các đối tượng khác nhau có thể hoạt động được với nhau.
 -> Bridge: Chia nhỏ một class to thành các class con cùng nhóm chức năng -> hoạt động độc lập nhau -> giảm thiểu tác động.
 -> Composite: Lấy ví dụ là cây thư mục (thư mục chứa files và tập các thư mục con, thư mục con lại chứa file và tập các thư mục con khác).
 -> Decorator: Thêm những tính năng mới mà không thay đổi cấu trúc của đối tượng.
 -> Facade: Ẩn đi logic phức tạp, chỉ đưa cho người dùng các phương thức tiện ích, dễ xử dụng (giống như mẫu builder)
 -> Proxy: Che đậy real object, muốn sử dụng phải thông qua một proxy object. Mục đích security, lazy loading...
 -> Flyweight:

* Nhóm hành vi:
 -> Template function: Công việc thường làm, giải pháp cung cấp cho việc giải quyết vấn đề code lặp, các logic đi chung một hướng nhưng chỉ cần thay đổi một phần nhỏ trong logic để tuỳ biến theo từng đối tượng(dựa trên 1 đối tượng cha).
 -> Visitor: Trong hướng đối tượng có một tính chất mà nếu không sử dụng cẩn thận sẽ dẫn đến lỗi mà ta không ngờ đó là tính Overload của function. 
 	-> Giả sử đối tượng A có tập các functions tên là "muaSach", các đối tượng {B -> B1 -> B2 -> Bn} có thể là các loại sách khác nhau nhưng được kế thừa từ 1 đối tượng gốc là B là input của function "muaSach" => B có thể được khai báo và định nghĩa bằng B1, B2 hoặc Bn.
 	-> Vấn đề: đối tượng sách được mua là B1 hay Bn đi chăng nữa nhưng dược khai báo là B thì đối số được dùng cho input lúc này vẫn được xem là B(mặc dù vùng nhớ của nó được khai báo là B1 hay Bn)
 	-> Giải quyết:
 		C1: Khai báo đúng kiểu dữ liệu(Cách này củ chuối vì không nhất thiết khi khai báo ta phải khai báo cụ thể loại sách nào).
 		C2: Double dispatch -> Ta thay cụm từ "A mua sách B" bằng "Sách B được A mua".
