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

* Nhớm cấu trúc:

