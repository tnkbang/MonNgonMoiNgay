# Món Ngon Mỗi Ngày

Website quản lý và giới thiệu các món ăn đến mọi người. Có chức năng phục vụ đặt món và quản bá món ăn.
</br>
Được xây dựng trên nền ASP.Net Core 6 MVC và Boostrap 4

## Cài đặt

```
git clone https://github.com/tnkbang/MonNgonMoiNgay.git
```

Lấy file script sql tại:
```
./wwwroot/SQL/File_csdl.sql
```

Cấu hình kết nối csdl tại:
```
./Models/MonNgonMoiNgayContext.cs

Change: "Data Source=YourDatabaseEngine;Initial Catalog=MonNgonMoiNgay;Integrated Security=True"
```

Cần đổi cấu hình API login Google tại:
```
./wwwroot/js/account.js
```

## Demo

![This is an image](/MonNgonMoiNgay/wwwroot/demo/trangchu.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/monan.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/chitietmon.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/themmon.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/dangnhap.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/giohang.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/chat.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/quanlymon.png)
![This is an image](/MonNgonMoiNgay/wwwroot/demo/quanlynguoidung.png)

Và nhiều hơn thế nữa.....