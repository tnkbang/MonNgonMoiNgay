Create database MonNgonMoiNgay
GO
use MonNgonMoiNgay
GO

create table LoaiND(
	Ma_Loai char(2) primary key,
	Ten_Loai nvarchar(20)
)

create table NguoiDung(
	Ma_ND char(7) primary key,
	Ma_Loai char(2) references LoaiND(Ma_Loai),
	Ho_Lot nvarchar(20),
	Ten nvarchar(7),
	Ngay_Sinh datetime,
	Gioi_Tinh int,
	SDT varchar(11),
	Email varchar(50) not null unique,
	Mat_Khau varchar(32) not null,
	Img_Avt nvarchar(100),
	Dia_Chi nvarchar(100),
	Trang_Thai bit not null,
	Ngay_Tao datetime
)

create table TinNhan(
	ID int primary key,
	Nguoi_Gui char(7) references NguoiDung(Ma_ND),
	Nguoi_Nhan char(7) references NguoiDung(Ma_ND),
	Thoi_Gian datetime not null,
	Noi_Dung nvarchar(500) not null,
	Trang_Thai bit not null,
	Lien_Ket varchar(100)
)

create table ThongBao(
	Ma_TB char(11) primary key,
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Tieu_De nvarchar(50) not null,
	Noi_Dung nvarchar(200),
	Thoi_Gian datetime not null,
	Trang_Thai bit not null,
	Lien_Ket varchar(100),
)

create table PhanHoi(
	Ma_PH char(11) primary key,
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Chi_Muc nvarchar(50) not null,
	Noi_Dung nvarchar(200),
	Thoi_Gian datetime not null
)

create table TinhTP(
	Ma_TP char(2) primary key,
	Ten_TP nvarchar(50)
)

create table QuanHuyen(
	Ma_QH char(3) primary key,
	Ma_TP char(2) not null references TinhTP(Ma_TP),
	Ten_QH nvarchar(50)
)

create table XaPhuong(
	Ma_XP char(3) primary key,
	Ma_QH char(3) not null references QuanHuyen(Ma_QH),
	Ten_XP nvarchar(50)
)

create table LoaiMonAn(
	Ma_Loai char(3) primary key,
	Ten_Loai nvarchar(50) not null
)

create table BaiDang(
	Ma_BD char(11) primary key,
	Ma_Loai char(3) not null references LoaiMonAn(Ma_Loai),
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Thoi_Gian datetime not null,
	Ten_Mon nvarchar(50) not null,
	Mo_Ta nvarchar(500),
	Gia_Tien int not null,
	Ma_XP char(3) references XaPhuong(Ma_XP),
	Dia_Chi nvarchar(100),
	Trang_Thai int not null
)

create table HinhAnh(
	Ma_BD char(11) not null references BaiDang(Ma_BD),
	Url_Image nvarchar(200) not null,
	primary key (Ma_BD, Url_Image)
)

create table BaiDangDuocLuu(
	Ma_BD char(11) not null references BaiDang(Ma_BD),
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Thoi_Gian datetime not null
	primary key(Ma_BD, Ma_ND)
)

create table YeuThichBaiDang(
	Ma_BD char(11) not null references BaiDang(Ma_BD),
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Thoi_Gian datetime not null
	primary key(Ma_BD, Ma_ND)
)

create table DayBaiDang(
	Ma_BD char(11) not null references BaiDang(Ma_BD),
	Ma_ND char(7) not null references NguoiDung(Ma_ND),
	Thoi_Gian datetime not null
	primary key(Ma_BD, Ma_ND)
)

GO
INSERT [dbo].[LoaiMonAn] ([Ma_Loai], [Ten_Loai]) VALUES (N'001', N'Lẩu')
INSERT [dbo].[LoaiMonAn] ([Ma_Loai], [Ten_Loai]) VALUES (N'002', N'Đồ Uống')
INSERT [dbo].[LoaiMonAn] ([Ma_Loai], [Ten_Loai]) VALUES (N'003', N'Đồ Ăn')
INSERT [dbo].[LoaiMonAn] ([Ma_Loai], [Ten_Loai]) VALUES (N'004', N'Món Nướng')
INSERT [dbo].[LoaiMonAn] ([Ma_Loai], [Ten_Loai]) VALUES (N'005', N'Món Ăn Khác')
GO
INSERT [dbo].[LoaiND] ([Ma_Loai], [Ten_Loai]) VALUES (N'01', N'Admin')
INSERT [dbo].[LoaiND] ([Ma_Loai], [Ten_Loai]) VALUES (N'02', N'User')
INSERT [dbo].[LoaiND] ([Ma_Loai], [Ten_Loai]) VALUES (N'03', N'Nhân Viên')
INSERT [dbo].[LoaiND] ([Ma_Loai], [Ten_Loai]) VALUES (N'04', N'Người Bán Hàng')
INSERT [dbo].[LoaiND] ([Ma_Loai], [Ten_Loai]) VALUES (N'05', N'Khách Hàng')
GO
INSERT [dbo].[NguoiDung] ([Ma_ND], [Ma_Loai], [Ho_Lot], [Ten], [Ngay_Sinh], [Gioi_Tinh], [SDT], [Email], [Mat_Khau], [Img_Avt], [Dia_Chi], [Trang_Thai], [Ngay_Tao]) VALUES (N'U000001', N'01', N'Lâm Linh', N'Tuyết', CAST(N'2022-07-02T00:00:00.000' AS DateTime), 2, N'012345678', N'linhtuyet@gmail.com', N'E10ADC3949BA59ABBE56E057F20F883E', N'avt-U000001-350.jpg', N'Cần Thơ', 1, CAST(N'2022-04-05T18:37:51.557' AS DateTime))
INSERT [dbo].[NguoiDung] ([Ma_ND], [Ma_Loai], [Ho_Lot], [Ten], [Ngay_Sinh], [Gioi_Tinh], [SDT], [Email], [Mat_Khau], [Img_Avt], [Dia_Chi], [Trang_Thai], [Ngay_Tao]) VALUES (N'U000002', N'02', N'Khánh', N'Băng', CAST(N'2000-08-17T00:00:00.000' AS DateTime), 1, N'0833229121', N'trieukhanhbang123@gmail.com', N'B486D7696F563BA2B80EEB936BC63166', N'avt-U000002-236.jpg', N'Cần Thơ', 1, CAST(N'2022-06-18T22:55:45.127' AS DateTime))
INSERT [dbo].[NguoiDung] ([Ma_ND], [Ma_Loai], [Ho_Lot], [Ten], [Ngay_Sinh], [Gioi_Tinh], [SDT], [Email], [Mat_Khau], [Img_Avt], [Dia_Chi], [Trang_Thai], [Ngay_Tao]) VALUES (N'U000003', N'02', N'Trieu Nguyen Khanh', N'Bang', NULL, NULL, NULL, N'bangb1809328@student.ctu.edu.vn', N'72A43DB6E360E77A03F5ECB8282441F9', N'avt-U000003-912.jpg', NULL, 1, CAST(N'2022-07-02T21:28:13.710' AS DateTime))
INSERT [dbo].[NguoiDung] ([Ma_ND], [Ma_Loai], [Ho_Lot], [Ten], [Ngay_Sinh], [Gioi_Tinh], [SDT], [Email], [Mat_Khau], [Img_Avt], [Dia_Chi], [Trang_Thai], [Ngay_Tao]) VALUES (N'U000004', N'02', NULL, NULL, NULL, NULL, NULL, N'minhnguyet@gmail.com', N'E10ADC3949BA59ABBE56E057F20F883E', NULL, NULL, 1, CAST(N'2022-07-07T18:13:57.937' AS DateTime))
GO
INSERT [dbo].[TinhTP] ([Ma_TP], [Ten_TP]) VALUES (N'64', N'Vĩnh Long')
INSERT [dbo].[TinhTP] ([Ma_TP], [Ten_TP]) VALUES (N'65', N'Cần Thơ')
INSERT [dbo].[TinhTP] ([Ma_TP], [Ten_TP]) VALUES (N'66', N'Đồng Tháp')
INSERT [dbo].[TinhTP] ([Ma_TP], [Ten_TP]) VALUES (N'67', N'An Giang')
INSERT [dbo].[TinhTP] ([Ma_TP], [Ten_TP]) VALUES (N'68', N'Kiên Giang')
GO
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'001', N'65', N'Quận Ninh Kiều')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'002', N'65', N'Quận Bình Thủy')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'003', N'65', N'Quận Cái Răng')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'004', N'65', N'Quận Ô Môn')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'005', N'65', N'Huyện Phong Điền')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'006', N'65', N'Huyện Cờ Đỏ')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'007', N'65', N'Huyện Vĩnh Thạnh')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'008', N'65', N'Quận Thốt Nốt')
INSERT [dbo].[QuanHuyen] ([Ma_QH], [Ma_TP], [Ten_QH]) VALUES (N'009', N'65', N'Huyện Thới Lai')
GO
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'001', N'001', N'Phường Cái Khế')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'002', N'001', N'Phường An Hòa')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'003', N'001', N'Phường Bình Thới')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'004', N'001', N'Phường An Nghiệp')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'005', N'001', N'Phường An Cư')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'006', N'001', N'Phường Xuân Khánh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'007', N'001', N'Phường Tân An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'008', N'001', N'Phường Hưng Lợi')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'009', N'001', N'Phường An Phú')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'010', N'001', N'Phường An Khánh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'011', N'001', N'Phường An Bình')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'012', N'004', N'Phường Châu Văn Liêm')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'013', N'004', N'Phường Thới Hòa')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'014', N'004', N'Phường Thới Long')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'015', N'004', N'Phường Long Hưng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'016', N'004', N'Phường Thới An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'017', N'004', N'Phường Phước Thới')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'018', N'004', N'Phường Trường Lạc')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'019', N'002', N'Phường Bình Thủy')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'020', N'002', N'Phường Trà An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'021', N'002', N'Phường Trà Nóc')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'022', N'002', N'Phường Thới An Đông')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'023', N'002', N'Phường An Thới')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'024', N'002', N'Phường Bùi Hữu Nghĩa')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'025', N'002', N'Phường Long Hòa')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'026', N'002', N'Phường Long Tuyền')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'027', N'003', N'Phường Lê Bình')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'028', N'003', N'Phường Hưng Phú')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'029', N'003', N'Phường Hưng Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'030', N'003', N'Phường Ba Láng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'031', N'003', N'Phường Thường Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'032', N'003', N'Phường Phú Thứ')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'033', N'003', N'Phường Tân Phú')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'034', N'008', N'Phường Thốt Nốt')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'035', N'008', N'Phường Thới Thuận')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'036', N'008', N'Phường Thuận An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'037', N'008', N'Phường Tân Lộc')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'038', N'008', N'Phường Trung Nhứt')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'039', N'008', N'Phường Thạnh Hoà')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'040', N'008', N'Phường Trung Kiên')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'041', N'008', N'Phường Tân Hưng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'042', N'008', N'Phường Thuận Hưng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'043', N'007', N'Xã Vĩnh Bình')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'044', N'007', N'Thị trấn Thanh An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'045', N'007', N'Thị trấn Vĩnh Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'046', N'007', N'Xã Thạnh Mỹ')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'047', N'007', N'Xã Vĩnh Trinh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'048', N'007', N'Xã Thạnh An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'049', N'007', N'Xã Thạnh Tiến')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'050', N'007', N'Xã Thạnh Thắng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'051', N'007', N'Xã Thạnh Lợi')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'052', N'007', N'Xã Thạnh Qưới')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'053', N'007', N'Xã Thạnh Lộc')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'054', N'006', N'Xã Trung An')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'055', N'006', N'Xã Trung Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'056', N'006', N'Xã Thạnh Phú')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'057', N'006', N'Xã Trung Hưng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'058', N'006', N'Thị trấn Cờ Đỏ')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'059', N'006', N'Xã Thới Hưng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'060', N'006', N'Xã Đông Hiệp')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'061', N'006', N'Xã Đông Thắng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'062', N'006', N'Xã Thới Đông')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'063', N'006', N'Xã Thới Xuân')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'064', N'005', N'Thị trấn Phong Điền')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'065', N'005', N'Xã Nhơn Ái')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'066', N'005', N'Xã Giai Xuân')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'067', N'005', N'Xã Tân Thới')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'068', N'005', N'Xã Trường Long')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'069', N'005', N'Xã Mỹ Khánh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'070', N'005', N'Xã Nhơn Nghĩa')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'071', N'009', N'Thị trấn Thới Lai')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'072', N'009', N'Xã Thới Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'073', N'009', N'Xã Tân Thạnh')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'074', N'009', N'Xã Xuân Thắng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'075', N'009', N'Xã Đông Bình')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'076', N'009', N'Xã Đông Thuận')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'077', N'009', N'Xã Thới Tân')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'078', N'009', N'Xã Trường Thắng')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'079', N'009', N'Xã Định Môn')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'080', N'009', N'Xã Trường Thành')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'081', N'009', N'Xã Trường Xuân')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'082', N'009', N'Xã Trường Xuân A')
INSERT [dbo].[XaPhuong] ([Ma_XP], [Ma_QH], [Ten_XP]) VALUES (N'083', N'009', N'Xã Trường Xuân B')
GO
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-001', N'003', N'U000001', CAST(N'2022-07-07T17:07:13.580' AS DateTime), N'Bánh Cống', N'Nói đến các món ăn ngon Cần Thơ, thật không thể bỏ qua món bánh cống, món bánh dân dã, vừa rẻ lại còn ngon, hấp dẫn đến từng nguyên liệu. Với người Cần Thơ, bánh cống như một thức quà vặt, chứa đựng nhiều kỷ niệm. Với khách du lịch, chiếc vỏ bánh giòn giòn, ăn kèm với rau sống tạo nên một hương vị đầy lạ lẫm, ngon miệng.', 50000, N'005', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-002', N'003', N'U000001', CAST(N'2022-07-07T17:09:11.570' AS DateTime), N'Bánh Hỏi Heo Quay', N'Vùng đất Phong Điền Cần Thơ từ xa xưa đã có nhiều lò bánh hỏi truyền thống, để ăn kèm bánh hỏi thì heo quay là món chính không thể thiếu với cách quay heo đặc biệt ở đây mà bất kỳ ai dùng thử sẽ gây cảm giác ghiện vì thế không biết từ khi nào món bánh hỏi heo quay Phong Điền đã trở nên nổi tiếng khắp nơi và trở thành đặc sản Cần Thơ mà bất kỳ ai khi đến đây đều muốn thưởng thức.', 100000, N'065', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-003', N'002', N'U000001', CAST(N'2022-07-07T17:11:39.843' AS DateTime), N'Coffee A.T', N'Quán không chỉ phục vụ các loại thức uống phổ biến như cà phê, cà phê sữa, trà sữa, nước ngọt,... mà còn phục vụ các bánh mì, sandwich, hamburger, khoai tây chiên,... Với menu đa dạng, món ăn ngon, phục vụ nhanh gọn đã tạo nhiều điểm thu hút khách hàng đến đây. Vì khách của quán tập trung vào học sinh, sinh viên vậy nên giá cả tại quán cực kỳ phải chăng, chỉ với 50.000 thôi bạn có thể mang về nhiều đồ ăn vặt và ly cà phê thơm ngon.', 35000, N'007', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-004', N'003', N'U000001', CAST(N'2022-07-07T17:13:20.050' AS DateTime), N'Bánh Tằm Bì', N'Linh hồn của món bánh tằm bì Cần Thơ không thể thiếu nước cốt dừa sánh mịn. Nước dừa được đảo trên bếp lửa nhỏ liu riu, thêm chút muối, đường và bột gạo, sau đó khuấy đều đến khi sánh lại thì tắt bếp.
Thành phẩm món bánh tằm bì có vị ngon ngọt của thịt, dai giòn sần sật của bì heo và hành tỏi phi, mùi thơm của các loại rau thơm ăn kèm vô cùng hấp dẫn.', 50000, N'009', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-005', N'003', N'U000001', CAST(N'2022-07-07T17:14:51.400' AS DateTime), N'Bánh Tét Lá Cẩm', N'Để có một mẻ bánh tét lá cẩm ngon, quá trình chế biến rất công phu. Trước tiên phải lựa nếp thật tốt, không lẫn gạo tẻ mới làm cho đòn bánh dẻo, ngâm qua 6 tiếng sau đó để ráo, trộn với nước lá cẩm để lên màu tím đẹp mắt. Lá cẩm phải còn tươi, lá úa sẽ làm cho nước lá cẩm xuống màu. Sau khi ngâm nếp tương đối mềm thì sẽ xào chung với nước cốt dừa, nêm muối, đường trong thời gian khoảng một tiếng để  màu lá cẩm và vị bó của nước dừa ngấm vào từng hạt nếp.', 90000, N'023', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-006', N'003', N'U000001', CAST(N'2022-07-07T17:16:41.073' AS DateTime), N'Bánh Xèo', N'Bánh xèo nổi tiếng từ lâu ở Cần Thơ. Nó mang đến một hương vị bánh xèo Nam Bộ đặc trưng với vỏ bánh mỏng và giòn ngon. Nhưng điều đặc biệt nhất của bánh xèo vẫn là thịt vịt bằm và củ hủ dừa. Không phải nơi nào cũng có sự kết hợp tuyệt diệu như thế trong bánh xèo miền Tây. Cách làm bánh xèo miền Tây ở đây rất ngon và đặc biệt. Tuy nấu bằng thịt vịt nhưng đừng lo bị hôi nhé! Ở đây xử lý khá tốt. Tuy vậy chống chỉ định ai dị ứng thịt vịt nha!', 35000, N'011', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-007', N'004', N'U000001', CAST(N'2022-07-07T17:20:07.690' AS DateTime), N'Bò Nướng Ngói', N'Thịt bò tại Bò nướng ngói Cù Lần được ướp kĩ càng, thịt mềm và nướng lên rất thơm do có mùi hương của mè rang đã được thêm vào trước đó. Ngói được đặt trên bếp than, cho một ít dầu ăn để thịt không bị dính vào ngói. Miếng thịt bò chín vàng, tỏa hương nghi ngút, nóng hổi, cuộn với bún và bánh tráng, thêm tí rau sống, nào là xà lách, tía tô, dưa leo, chấm cùng nước mắm nêm thơm lừng, làm cho bất cứ thực khách khó tính nào cũng gật gù khen ngon.', 150000, N'005', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-008', N'003', N'U000001', CAST(N'2022-07-07T17:22:52.993' AS DateTime), N'Bún Riêu', N'Nói đến bún riêu, nhiều người sẽ nghĩ ngay đó là đặc sản của miền Tây nhưng ít ai biết, món này có nguồn gốc từ miền Bắc. Từ khoảng 50 năm nước, món bún riêu theo chân người Bắc vào Nam, thế là người ta lại biết đến món ăn này nhiều hơn. Tuy nhiên, bún riêu cua của người miền Nam không hẳn là giống miền Bắc, qua thời gian nó được thay đổi để phù hợp với khẩu vị của người Miền Nam.', 50000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-009', N'004', N'U000001', CAST(N'2022-07-07T17:26:59.287' AS DateTime), N'Cá Lóc Nướng Trui', N'Là trung tâm ẩm thực của vùng đồng bằng sông Cửu Long nên khi nói đến các món ăn ngon Cần Thơ không thể không kể đến món cá lóc nướng trui. Không biết có từ bao giờ, món cá lóc nướng trui cho đến bây giờ vẫn là đặc sản Cần Thơ gắn bó với bao người dân nơi đây. Thực khách từ phương xa khi đến du lịch Cần Thơ vẫn thường gọi món cá lóc nướng trui để thưởng thức cho bõ bèn.', 100000, N'010', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-010', N'003', N'U000001', CAST(N'2022-07-07T17:30:15.003' AS DateTime), N'Cơm Cháy Kho Quẹt', N'Nếu muốn thưởng thức món cơm cháy kho quẹt thì cơm cháy kho quẹt Má Bảy là địa chỉ không thể bỏ qua, hương vị đậm đà, giữ nguyên hương vị truyền thống được chế biến cẩn thận, ăn cùng cơm cháy chắc chắn bạn nên thử. Kho quẹt ở đây làm rất ngon có tép mỡ, tiêu tươi, và có tôm khô nữa. Ngoài ra điều đặc biệt ở đây là cơm cháy kho quẹt ở đây có trộn chung với nước cốt dừa cho nên rất là thơm, chỉ cần các bạn đi ngang qua thôi là các bạn ấy nghe mùi nước dừa rất là thơm.', 80000, N'008', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000001-011', N'004', N'U000001', CAST(N'2022-07-07T17:44:52.980' AS DateTime), N'Nem Nướng', N'Đậu Đỏ Quán nổi tiếng với món nem nướng Nha Trang, 1 phần nem nướng phù hợp cho một người ăn chỉ 39k bao gồm nem, bánh tráng cuốn chiên, khóm, dưa chua, dưa leo và bánh hỏi. Nem tại đây được đánh giá khá đặc biệt, nem được ướp vừa ăn, nướng thơm lừng và mềm, còn nước chấm của quán thì không giống các chỗ khác, không mặn như mắm nêm mà ngọt nhẹ và hơi sánh rất lạ miệng và ngon.', 39000, N'001', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-001', N'004', N'U000002', CAST(N'2022-07-07T17:46:47.103' AS DateTime), N'Đồ Nướng Hẻm 132', N'Đồ nướng hẻm 132 đa dạng các món ăn như lòng gà, mề gà, phao câu, chẳng vừng heo, tôm, xúc xích, bò cuộn nấm kim châm, vú heo nướng,...Bạn nên đi sớm nhé vì nếu đi trễ quán sẽ rất đông và dễ hết đồ ăn. Ngoài ra, hải sản tại đây cũng rất tươi mới, được tẩm ướp gia vị vừa ăn. Tất cả món nướng tại Đồ nướng hẻm 132 sẽ được ăn kèm với đậu bắp nướng, dưa chua và rau răm, tất cả hòa quyện tạo nên trải nghiệm ẩm thực tuyệt vời.', 50000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-002', N'003', N'U000002', CAST(N'2022-07-07T17:55:20.660' AS DateTime), N'Gỏi Cuốn', N'Gỏi cuốn chắc tay, ăn ngon, bên trong có thịt, tôm, bún và rau. Tôm với thịt khá mềm, ngon, ngọt. Tương ăn vừa miệng, không quá mặn.', 12000, N'010', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-003', N'002', N'U000002', CAST(N'2022-07-07T17:57:34.757' AS DateTime), N'Highlands Coffee', N'Từ tình yêu với Việt Nam và niềm đam mê cà phê, năm 1999, thương hiệu Highlands Coffee ra đời với khát vọng nâng tầm di sản cà phê lâu đời của Việt Nam và lan rộng tinh thần tự hào, kết nối hài hòa giữa truyền thống với hiện đại. Sau nhiều năm phát triển Highlands Coffe ngày càng phát triển với số lượng các quán Highlands Coffe được trải rộng khắp tỉnh thành Việt Nam cũng như rất nhiều nơi trên thế giới.', 80000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-004', N'001', N'U000002', CAST(N'2022-07-07T17:58:59.263' AS DateTime), N'Lẩu Băng Chuyền Kichi', N'Kichi Kichi là nhà hàng lẩu nổi tiếng tại Cần Thơ, quán ăn này có 3 cơ sở tại Vincom Hùng Vương, Vincom Xuân Khánh và Lotte Mart Cần Thơ. Với một phiếu buffet, bạn có thể thoải mái thưởng thức nhiều món ăn đặc sắc trong dây chuyền 100 món từ thịt bò, thịt heo, các loại rau củ. Lẩu băng chuyền Vincom Cần Thơ được nhiều du khách đánh giá cao về chất lượng.', 250000, N'003', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-005', N'001', N'U000002', CAST(N'2022-07-07T18:00:26.203' AS DateTime), N'Lẩu Nướng Kiseki', N'Nếu bạn đang tìm kiếm một quán lẩu ngon Cần Thơ thì có thể ghé qua quán Kiseki. Ưu điểm của quán ăn này là tọa lạc ở vị trí rất dễ tìm, menu đa dạng với nhiều món ăn hấp dẫn giúp bạn thoải mái chọn lựa. Bên cạnh món lẩu Cần Thơ nổi tiếng, tại đây còn có đồ nướng được tẩm ướp rất thơm ngon. Vì vậy, đây cũng được xem là một nhà hàng đáng tiền cho trải nghiệm ẩm thực Cần Thơ.', 200000, N'009', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-006', N'001', N'U000002', CAST(N'2022-07-07T18:02:25.400' AS DateTime), N'Lẩu baba', N'Quán 225 không chỉ là quán ăn ngon với du khách mà đây còn là địa điểm ăn uống rất quen thuộc với người dân Cần Thơ. Bên cạnh món lẩu ba ba ngon “thần sầu” thì tại đây còn phục vụ rất nhiều món ăn thơm ngon như: kho cá lóc gỏi xoài, bắp xào tôm khô, tàu hủ chiên sả ớt,… ', 333000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-007', N'001', N'U000002', CAST(N'2022-07-07T18:03:34.350' AS DateTime), N'Lẩu Bần', N'Lẩu bần là một loại lẩu Cần Thơ đặc biệt thơm – ngon. Nồi lẩu có vị mắm đậm đà, kèm theo đó là những loại rau đậm chất Nam Bộ như bông súng, điên điển. Nếu bạn muốn thưởng thức hương vị ẩm thực dân dã của miền Tây thì có thể ghé qua địa điểm ăn uống Cần Thơ ngon bổ rẻ ở Cồn Ấu.', 150000, N'028', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-008', N'001', N'U000002', CAST(N'2022-07-07T18:08:21.477' AS DateTime), N'Lẩu Cá Kèo', N'Điều khiến cho nhiều du khách thường xuyên ghé quán Chị Tôi để thưởng thức lẩu Cần Thơ là không gian quan rất “xanh”. Không gian quán rất rộng với những chòi lá đậm chất miệt vườn miền Tây. Tại đây bạn sẽ được thưởng thức rất nhiều món ăn đặc sản được chế biến thơm ngon, hấp dẫn.', 230000, N'001', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-009', N'001', N'U000002', CAST(N'2022-07-07T18:09:28.763' AS DateTime), N'Lẩu Chay', N'Nếu bạn ăn chay nhưng vẫn muốn thưởng thức hương vị của món lẩu Cần Thơ thì nên ghé quán Tư Đậu. Nước lẩu ở đây được pha chế rất vừa miệng, thơm ngon. Đồ ăn kèm bao gồm: chả cá trắng chay, cá viên chay, tàu hủ, đậu phụ, các loại rau ăn kèm. Ngoài ra, điều làm nên sức hút của quán lẩu này còn phải kể đến nước chấm rất đặc biệt.', 70000, N'008', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-010', N'001', N'U000002', CAST(N'2022-07-07T18:10:55.297' AS DateTime), N'Lẩu Cua Đồng', N'Lẩu Cua Đồng có không gian sạch sẽ, rộng rãi và mát mẻ, view nhìn ra bờ sông, cả bãi giữ xe cho khách khá thoáng. Giá cả bình dân nên phù hợp cho mọi tầng lớp, đối tượng khách, vì thế khách ở đây một ngày cũng tương đối đông. Menu đa dạng đủ các món nhưng đặc trưng nhất là “LẨU CUA ĐỒNG“. Nước lẩu thanh, ngọt, chua nhẹ của cà chua, thơm của lá quế.', 200000, N'004', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-011', N'001', N'U000002', CAST(N'2022-07-07T18:13:10.300' AS DateTime), N'Lẩu Kem', N'Nhắc đến lẩu Cần Thơ, chắc hẳn bạn sẽ thường nghĩ đến những món ăn đậm đà. Tuy nhiên, bạn cũng có thể thưởng thức một loại “lẩu” rất đặc biệt – đó chính là lẩu kem. Những chiếc kem hấp dẫn đủ vị, đủ màu sắc thu hút nhiều thực khách, đặc biệt với trẻ em và giới trẻ, đây thật sự là “món tủ” không thể bỏ lỡ.', 150000, N'007', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-012', N'002', N'U000002', CAST(N'2022-07-07T20:05:08.467' AS DateTime), N'Trà Sữa An Viên', N'Tiệm trà An Viên là điểm đến yêu thích của nhiều bạn trẻ và tín đồ trà sữa Cần Thơ. Thức uống tại đây đều được pha chế với nguyên liệu chất lượng, sau đó đựng cẩn thận trong những chiếc ly xinh xắn, độc đáo. Chắc chắn đây là sẽ địa chỉ quán trà sữa lý tưởng làm hài lòng các bạn trẻ Cần Thơ và du khách nếu có dịp ghé thăm.', 15000, N'008', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-013', N'002', N'U000002', CAST(N'2022-07-07T20:08:26.610' AS DateTime), N'Nước ép Green Juice', N'Nước ép lúc nào cũng tươi ngon.
Được giao hàng miễn phí 0983.913.289 khi mua >5ly trong vòng 3km từ Green Juice
Giá cả lại hợp lý từ 12-25k/ly
Các loại nước ép giảm cân như: Bưởi ép, dâu ép, khóm ép﻿', 15000, N'005', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-014', N'002', N'U000002', CAST(N'2022-07-07T20:11:14.243' AS DateTime), N'Sinh tố 228', N'Quán nằm ngay con hẻm khá đông khách, lượng khách mua về nhiều hơn là ngồi tại quán Sinh tố 228 được mệnh danh là sinh tố không nghỉ- nghỉ ở đây là nghỉ ngơi vì lượng khách rất tấp nập, quán có một không gian ngồi trong nhà khá ổn, mới xây nhưng mình thích ngồi ở ngoài hiên nhà hơn vì ngồi ngoài hiên vào buổi tối khá mát mẻ.', 20000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000002-015', N'002', N'U000002', CAST(N'2022-07-16T18:09:37.343' AS DateTime), N'Sinh Tố Trái Cây', N'Sinh tố trái cây bổ sung nhiều vitamin và tốt cho sức khỏe.', 15000, N'010', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-001', N'001', N'U000004', CAST(N'2022-07-07T18:15:25.140' AS DateTime), N'Lẩu Mắm - Má Năm', N'Một trong những quán lẩu mắm ngon ở Cần Thơ nổi tiếng là quán Má Năm. Nghe tên quán đã thấy được chất miền Tây Nam Bộ, quán không chỉ có đồ ăn ngon, giá rẻ mà phong cách phục vụ cũng rất tận tình, chuyên nghiệp. Set lẩu Cần Thơ ở đây có nhiều thành phần khác nhau, bao gồm thịt, cá và các loại rau củ. Đây thật sự là địa điểm lý tưởng để tụ họp bạn bè, người thân.', 200000, N'005', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-002', N'001', N'U000004', CAST(N'2022-07-07T18:16:53.943' AS DateTime), N'Lẩu Thái Pallet', N'Quán Pallet nổi tiếng nhờ vào menu ẩm thực đa dạng, chất lượng phục vụ chuyên nghiệp cùng với mức giá phải chăng. Tại quán ăn này, bạn có thể gọi món lẩu Thái với phần nước dùng đặc biệt thơm ngon. Ngoài ra, những món ăn kèm của quán cũng rất đa dạng cho thực khách có thể thoải mái lựa chọn.', 350000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-003', N'002', N'U000004', CAST(N'2022-07-07T18:18:25.040' AS DateTime), N'Lumos Coffee', N'Những loại thức uống take away nổi tiếng tại đây gồm có trà đào, trà sữa, hồng trà, cà phê sữa. Ngoài ra, quán còn rất nổi tiếng với những món bánh ngọt, bánh sữa với nhiều mức giá, phù hợp với nhiều đối tượng khách hàng. Các vị trà sữa đều mang nét truyền thống với hương trà kết cùng với hương sữa đậm đà, chân trâu giòn, dai. Bánh quán có nhiều loại từ bánh sinh nhật, kỷ niệm đến những miếng bánh nhỏ xinh tráng miệng, hay ăn sáng.', 39000, N'004', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-004', N'001', N'U000004', CAST(N'2022-07-07T18:19:38.910' AS DateTime), N'Lẩu Nhà Quê', N'Nhắc đến những món ngon Cần Thơ thì không thể bỏ qua món lẩu. Tại đây, lẩu được chế biến rất đa dạng, sử dụng những nguyên liệu dân dã, đồng quê nên được thực khách đánh giá cao. Tại quán Nhà Quê, bạn sẽ được thưởng thức món lẩu vừa rẻ vừa ngon, mỗi người chỉ cần 100.000 VNĐ đã có thể thoải mái thưởng thức lẩu Cần Thơ nóng hổi “vừa thổi vừa ăn”.', 79000, N'009', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-005', N'004', N'U000004', CAST(N'2022-07-07T18:20:55.320' AS DateTime), N'Nướng Xiên Que Panda', N'Nhắc đến xiên que nướng, quả thực phải nghĩ ngay đến Xiên que Panda. Hơn gì hết, các món ăn tại đây đúng chuẩn tiêu chí "Ngon - Bổ - Rẻ". Từ các món thịt như thịt bò Úc, ba rọi heo, vú heo cho đến các món hải sản như bạch tuộc ướp sa tế, tôm nướng mọi, chạo hải sản hay các xiên que xúc xích, sụn gà, hồ lô,...cực kì hấp dẫn.', 70000, N'006', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-006', N'004', N'U000004', CAST(N'2022-07-07T18:22:04.543' AS DateTime), N'Ốc Nướng Tiêu', N'Xứ Tây Đô nổi tiếng với nhiều món ăn ngon Cần Thơ mang hương vị dân dã nhưng lại không thiếu đi sự đậm đà, ốc nướng tiêu là một trong số đó. Với miệt vùng sông nước dồi dào những sản vật đồng quê, món ốc nướng tiêu ở Cần Thơ có cách chế biến đơn giản, song mang lại cảm giác ấm bụng, lạ miệng vô cùng.', 75000, N'010', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-007', N'001', N'U000004', CAST(N'2022-07-07T18:23:38.203' AS DateTime), N'Lẩu Dê', N'Quán lẩu dê là một trong những quán ăn Cần Thơ bán từ rất lâu. Món ăn nổi tiếng nhất ở đây là lẩu dê thơm ngon, đậm vị. Bên cạnh đó, quán còn có thêm cá món nướng, xào giúp bạn thoải mái lựa chọn. Hầu hết đồ ăn tại đây được chế biến, tẩm ướp từ đầu bếp người Tây, vì vậy bạn có thể đến đây để trải nghiệm sức hấp dẫn của một trong những loại lẩu Cần Thơ đặc  trưng.', 200000, N'008', N'10.024836010694717-105.75788019678882', 1)
INSERT [dbo].[BaiDang] ([Ma_BD], [Ma_Loai], [Ma_ND], [Thoi_Gian], [Ten_Mon], [Mo_Ta], [Gia_Tien], [Ma_XP], [Dia_Chi], [Trang_Thai]) VALUES (N'U000004-008', N'001', N'U000004', CAST(N'2022-07-07T18:24:55.720' AS DateTime), N'Vịt Nấu Chao', N'Vịt nấu chao là một trong những món đặc sản Cần Thơ có hương vị vô cùng đặc biệt, đủ sức hấp dẫn với mọi thực khách. Nguyên liệu chính làm nên món ăn là vịt xiêm, với đặc trưng nhiều thịt ít mỡ, giảm độ dầu mỡ.
Để làm được món ngon chuẩn vị nhất, người đầu bếp phải đảm bảo từng thớ thịt được tẩm ướt, thấm đậm gia vị, mềm mại mà không bị hôi. Kết hợp với chao, món ăn càng “dậy mùi” thơm lừng, vừa béo ngậy nhưng lại không hề bị ngấy.', 300000, N'009', N'10.024836010694717-105.75788019678882', 1)
GO
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-001', N'U000001-001-banh-cong-can-tho.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-001', N'U000001-001-banh-cong-la-banh-gi-banh-cong-dac-san-o-dau-tai-sao-lai-goi-tipsnote-800x450.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-001', N'U000001-001-banh-cong-la-banh-gi-banh-cong-dac-san-o-dau-tai-sao-lai-goi-tipsnote-800x450-2.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-001', N'U000001-001-cach-lam-banh-cong--banh-cong-soc-trang-don-gian-tai-nha--7.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-002', N'U000001-002-img-6273-1496031760088.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-002', N'U000001-002-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-002', N'U000001-002-photo.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-002', N'U000001-002-tải xuống.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-003', N'U000001-003-banh-mi-va-cafe-at-753561.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-003', N'U000001-003-banh-mi-va-cafe-at-753562.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-004', N'U000001-004-dia-chi-ban-banh-tam-bi-ngon-nhat-tai-tpho-chi-minh-187682.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-004', N'U000001-004-foody-mobile-banh-tam-bi-to-chau.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-004', N'U000001-004-Untitled-3.jp1a1260-1200x676.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-005', N'U000001-005-0 (1).jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-005', N'U000001-005-00000-1200x676.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-005', N'U000001-005-banh-tet-la-cam-can-tho-mon-dac-san-thom-ngon-khong-the-bo-lo-01-1649234318.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-006', N'U000001-006-1563873866-731-thumbnail_schema_article.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-006', N'U000001-006-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-006', N'U000001-006-Untitled-2-1200x676-3.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-007', N'U000001-007-bo-nuong-ngoi-450x300.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-007', N'U000001-007-bonuongngoi-bd.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-007', N'U000001-007-bo-nuong-ngoi-cu-lan-662875.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-007', N'U000001-007-bo-nuong-ngoi-cu-lan-662877.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-008', N'U000001-008-bun-rieu.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-008', N'U000001-008-bun-rieu-vit-thumbnail.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-008', N'U000001-008-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-009', N'U000001-009-cach-lam-ca-loc-nuong-trui-thom-lung-hap-dan-don-760x367.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-009', N'U000001-009-cach-lam-mon-ca-loc-nuong-trui-dan-da-dac-san-mien-tay-202206041532565016.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-009', N'U000001-009-ca-loc-nuong-trui-2-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-009', N'U000001-009-mon-an-ngon-can-tho.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-010', N'U000001-010-cach-lam-com-chay-kho-quet-gion-tan-an-hoai-khong-chan.jpg6-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-010', N'U000001-010-ma-bay-com-chay-kho-quet-cho-dem-tran-phu-688500.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-010', N'U000001-010-ma-bay-com-chay-kho-quet-cho-dem-tran-phu-688505.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-011', N'U000001-011-mach-ban-cach-lam-nem-nuong-bang-chao-202106181648022849.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-011', N'U000001-011-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000001-011', N'U000001-011-nem-nuong-mien-tay620x400.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-001', N'U000002-001-do-nuong-hem-132-662885.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-001', N'U000002-001-do-nuong-hem-132-662886.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-001', N'U000002-001-quan-suu-ca-662883.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-001', N'U000002-001-quan-suu-ca-662884.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-002', N'U000002-002-cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202203021427281747.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-002', N'U000002-002-file_restaurant_photo_majw_16026-0b202777-201014115114.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-002', N'U000002-002-foody-upload-api-foody-mobile-img_20210405_154724c-210405212555.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-003', N'U000002-003-HCO-7576-DELIVERY-MENU-REFRESH-ONLINE-NO-CAKEBANHMI.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-003', N'U000002-003-highlands-coffee-332910.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-003', N'U000002-003-highlands-coffee-332912.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-004', N'U000002-004-foody-kichi-kichi-lau-bang-chuyen-vincom-can-tho-240-637431541662967297.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-004', N'U000002-004-foody-kichi-kichi-lau-bang-chuyen-vincom-can-tho-252-636339146129337210.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-004', N'U000002-004-foody-kichi-kichi-lau-bang-chuyen-vincom-can-tho-517-636420774517653573.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-004', N'U000002-004-foody-kichi-kichi-lau-bang-chuyen-vincom-can-tho-668-636380051099953698.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-004', N'U000002-004-foody-kichi-kichi-lau-bang-chuyen-vincom-can-tho-865-637568489974892780.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-005', N'U000002-005-foody-checkin-kiseki-quan-lau-tu-chon-359-636113576565270812.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-005', N'U000002-005-foody-checkin-kiseki-quan-lau-tu-chon-938-636236551838143304.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-005', N'U000002-005-foody-checkin-kiseki-quan-lau-tu-chon-997-636060368177588021.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-005', N'U000002-005-foody-kiseki-quan-lau-tu-chon-333-636084196316009661.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-006', N'U000002-006-lau-ba-ba (1).jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-006', N'U000002-006-lau-ba-ba.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-006', N'U000002-006-lau-can-tho-14_1631186074.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-006', N'U000002-006-Lau-nam-ba-ba-an-o-dau-la-ngon-nhat-tai-ha-noi.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-006', N'U000002-006-tải xuống.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-007', N'U000002-007-081804-internet---l-u-b-n-ph--sa-ct.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-007', N'U000002-007-081809-internet---l-u-b-n-ph--sa.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-007', N'U000002-007-diem-mat-goi-ten-15-top-quan-lau-can-tho-dang-dong-tien-5-1649254152.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-007', N'U000002-007-lau-ban.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-007', N'U000002-007-lau-can-tho-02_1631188190.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-008', N'U000002-008-foody-mobile-lau-ca-keo-ba-huyen--679-635742948409705112.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-008', N'U000002-008-lau-ca-keo-2.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-008', N'U000002-008-lau-can-tho-01_1631187967.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-008', N'U000002-008-tải xuống.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-009', N'U000002-009-hai-quan-lau-chay-cuc-noi-tieng-o-lang-dai-hoc-thu-duc-gia-chi-tu-35-ngan-1-1600308829.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-009', N'U000002-009-lau-can-tho-13_1631186023.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-009', N'U000002-009-lau-chay-hoang-dat-2-320671.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-009', N'U000002-009-quan-chay-moc-can-tho-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-009', N'U000002-009-vuon-chay-garden-516753.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-010', N'U000002-010-cach-nau-lau-cua-dong.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-010', N'U000002-010-laucuadong-1633836268-4368-1633836390.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-010', N'U000002-010-lẩu-cua-đồng-cần-thơ-1-1068x1068.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-010', N'U000002-010-lau-cua-dong-thom-ngon-chuan-vi.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-011', N'U000002-011-anh-3-2815-1431506191.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-011', N'U000002-011-lau-can-tho-11_1631185805.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-011', N'U000002-011-lau-kem-ha-noi-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-011', N'U000002-011-Lẩu-kem-Tây-Sơn.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-012', N'U000002-012-1-ly-tra-sua-bao-nhieu-calo-cach-uong-tra-sua-khong-tang-can-202107210040200928.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-012', N'U000002-012-cach-lam-tra-sua-1.png')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-012', N'U000002-012-tra-sua-tran-chau.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-013', N'U000002-013-1_5.png')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-013', N'U000002-013-10loai-nuoc-ep-trai-cay.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-013', N'U000002-013-2-cach-lam-nuoc-ep-mit-ngot-lim-thom-mat-moi-la-doi-vi-ngay-avt-1200x676.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-013', N'U000002-013-nuoc-ep-trai-cay-00-min.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-014', N'U000002-014-bi-quyet-pha-sinh-to-ngon-dung-dieu-ngay-tai-nha-1_760x507.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-014', N'U000002-014-cach-lam-sinh-to-600x337.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-014', N'U000002-014-cach-lam-sinh-to-dau-tay1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-014', N'U000002-014-Giam-Mo.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-014', N'U000002-014-sinh-to-bo.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-015', N'U000002-015-bi-quyet-pha-sinh-to-ngon-dung-dieu-ngay-tai-nha-1_760x507.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-015', N'U000002-015-cach-lam-sinh-to-600x337.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-015', N'U000002-015-cach-lam-sinh-to-dau-tay1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000002-015', N'U000002-015-sinh-to-bo.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-001', N'U000004-001-4.-Cát-Tiên-2-Quán-Lẩu-Mắm-min.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-001', N'U000004-001-lau-can-tho-7_1631185675.jpg')
GO
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-001', N'U000004-001-lau-mam-ma-nam.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-001', N'U000004-001-Top-10-quan-lau-mam-ngon-o-Can-Tho-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-002', N'U000004-002-LAM03924.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-002', N'U000004-002-lau-can-tho-15_1631186113.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-002', N'U000004-002-lau-thai-chua-cay.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-002', N'U000004-002-lau-thai-hai-san-chua-chua-cay-cay-danh-bay-cai-lanh-202111161130260017.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-002', N'U000004-002-nau-lau-thai-chuan-vi-ngon-nhu-the-nao.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-003', N'U000004-003-lumos-coffee-amp-cake-332254.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-003', N'U000004-003-lumos-coffee-amp-cake-332255.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-004', N'U000004-004-lau-can-tho-5_1631185513.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-004', N'U000004-004-lau-can-tho-6_1631185629.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-005', N'U000004-005-Cacmonxienquenuong-1200x676.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-005', N'U000004-005-foody-mobile--hh-jpg-776-636365993195448587.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-005', N'U000004-005-xien-que-panda-662859.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-005', N'U000004-005-xien-que-panda-662862.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-006', N'U000004-006-24.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-006', N'U000004-006-maxresdefault (1).jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-006', N'U000004-006-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-006', N'U000004-006-oc-nuong-tieu-can-tho.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-007', N'U000004-007-quan-lau-de-cay-dua-lau-de-ngon-o-ha-noi.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-007', N'U000004-007-quan-lau-de-ngon-can-tho-1.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-007', N'U000004-007-Review-top-5-quan-lau-de-Da-Lat-ngon-va.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-007', N'U000004-007-top-quan-lau-de-ngon-nhat-hcm.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-008', N'U000004-008-0.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-008', N'U000004-008-bi-quyet-lam-vit-nau-chao-ngon-thit-mem-khong-bi-hoi-202201101537106817.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-008', N'U000004-008-IMG-0391-vit-nau-chao.png')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-008', N'U000004-008-maxresdefault.jpg')
INSERT [dbo].[HinhAnh] ([Ma_BD], [Url_Image]) VALUES (N'U000004-008', N'U000004-008-vit-nau-chao-dam-chat-mien-tay-nam-bo.png')
GO
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-005', N'U000002', CAST(N'2022-07-07T20:12:29.167' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-006', N'U000002', CAST(N'2022-07-07T20:12:26.413' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-008', N'U000002', CAST(N'2022-07-07T20:12:21.823' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-007', N'U000004', CAST(N'2022-07-07T20:13:29.450' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-009', N'U000004', CAST(N'2022-07-07T20:13:06.073' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-011', N'U000004', CAST(N'2022-07-07T20:13:00.197' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-001', N'U000002', CAST(N'2022-07-07T20:12:10.757' AS DateTime))
INSERT [dbo].[BaiDangDuocLuu] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-007', N'U000002', CAST(N'2022-07-07T20:12:03.420' AS DateTime))
GO
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-003', N'U000002', CAST(N'2022-07-07T20:12:31.223' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-007', N'U000002', CAST(N'2022-07-07T20:12:25.077' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-009', N'U000002', CAST(N'2022-07-07T20:12:23.660' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-007', N'U000001', CAST(N'2022-07-07T20:20:40.510' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-007', N'U000004', CAST(N'2022-07-07T20:13:28.490' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-010', N'U000001', CAST(N'2022-07-07T20:34:36.417' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-010', N'U000004', CAST(N'2022-07-07T20:13:02.143' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-011', N'U000004', CAST(N'2022-07-07T20:12:59.547' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-012', N'U000001', CAST(N'2022-07-07T20:20:03.210' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-014', N'U000001', CAST(N'2022-07-07T20:20:01.493' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-002', N'U000002', CAST(N'2022-07-07T20:12:12.203' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-003', N'U000002', CAST(N'2022-07-07T20:12:14.243' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-004', N'U000001', CAST(N'2022-07-07T20:19:59.303' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-005', N'U000001', CAST(N'2022-07-07T20:19:57.953' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-006', N'U000001', CAST(N'2022-07-07T20:19:56.150' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-007', N'U000001', CAST(N'2022-07-07T20:19:54.067' AS DateTime))
INSERT [dbo].[YeuThichBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-008', N'U000001', CAST(N'2022-07-07T20:20:04.743' AS DateTime))
GO
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-001', N'U000001', CAST(N'2022-07-07T20:19:22.470' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-002', N'U000001', CAST(N'2022-07-07T20:19:23.917' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-007', N'U000001', CAST(N'2022-07-07T20:19:25.190' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-008', N'U000001', CAST(N'2022-07-07T20:19:25.867' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000001-010', N'U000001', CAST(N'2022-07-07T20:19:27.813' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-001', N'U000001', CAST(N'2022-07-07T20:19:27.010' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-002', N'U000001', CAST(N'2022-07-07T20:19:31.347' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-003', N'U000001', CAST(N'2022-07-07T20:19:29.183' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-004', N'U000001', CAST(N'2022-07-07T20:19:29.733' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000002-005', N'U000001', CAST(N'2022-07-07T20:19:30.540' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-001', N'U000004', CAST(N'2022-07-07T20:13:48.237' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-002', N'U000004', CAST(N'2022-07-07T20:13:50.513' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-003', N'U000004', CAST(N'2022-07-07T20:13:52.477' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-005', N'U000004', CAST(N'2022-07-07T20:18:52.333' AS DateTime))
INSERT [dbo].[DayBaiDang] ([Ma_BD], [Ma_ND], [Thoi_Gian]) VALUES (N'U000004-007', N'U000004', CAST(N'2022-07-07T20:13:54.547' AS DateTime))
GO
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-001', N'U000001', N'Lượt lưu mới', N'Bài đăng Bún Riêu nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:12:21.830' AS DateTime), 0, N'/Post/Detail?id=U000001-008')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-002', N'U000001', N'Lượt thích mới', N'Bài đăng Cá Lóc Nướng Trui nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:23.667' AS DateTime), 0, N'/Post/Detail?id=U000001-009')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-003', N'U000001', N'Lượt thích mới', N'Bài đăng Bò Nướng Ngói nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:25.083' AS DateTime), 0, N'/Post/Detail?id=U000001-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-004', N'U000001', N'Lượt lưu mới', N'Bài đăng Bánh Xèo nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:12:26.420' AS DateTime), 0, N'/Post/Detail?id=U000001-006')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-005', N'U000001', N'Lượt lưu mới', N'Bài đăng Bánh Tét Lá Cẩm nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:12:29.170' AS DateTime), 0, N'/Post/Detail?id=U000001-005')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000001-006', N'U000001', N'Lượt thích mới', N'Bài đăng Coffee A.T nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:31.227' AS DateTime), 0, N'/Post/Detail?id=U000001-003')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-001', N'U000002', N'Lượt thích mới', N'Bài đăng Lẩu Kem nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:59.550' AS DateTime), 0, N'/Post/Detail?id=U000002-011')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-002', N'U000002', N'Lượt lưu mới', N'Bài đăng Lẩu Kem nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:13:00.200' AS DateTime), 0, N'/Post/Detail?id=U000002-011')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-003', N'U000002', N'Lượt thích mới', N'Bài đăng Lẩu Cua Đồng nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:13:02.150' AS DateTime), 0, N'/Post/Detail?id=U000002-010')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-004', N'U000002', N'Lượt lưu mới', N'Bài đăng Lẩu Chay nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:13:06.077' AS DateTime), 0, N'/Post/Detail?id=U000002-009')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-005', N'U000002', N'Lượt thích mới', N'Bài đăng Lẩu Bần nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:13:28.500' AS DateTime), 0, N'/Post/Detail?id=U000002-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-006', N'U000002', N'Lượt lưu mới', N'Bài đăng Lẩu Bần nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:13:29.460' AS DateTime), 0, N'/Post/Detail?id=U000002-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-007', N'U000002', N'Lượt thích mới', N'Bài đăng Sinh tố 228 nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:20:01.497' AS DateTime), 0, N'/Post/Detail?id=U000002-014')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-008', N'U000002', N'Lượt thích mới', N'Bài đăng Trà Sữa An Viên nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:20:03.217' AS DateTime), 0, N'/Post/Detail?id=U000002-012')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-009', N'U000002', N'Lượt thích mới', N'Bài đăng Lẩu Bần nhận được lượt thích thứ 2.', CAST(N'2022-07-07T20:20:40.513' AS DateTime), 0, N'/Post/Detail?id=U000002-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000002-010', N'U000002', N'Lượt thích mới', N'Bài đăng Lẩu Cua Đồng nhận được lượt thích thứ 2.', CAST(N'2022-07-07T20:34:36.727' AS DateTime), 0, N'/Post/Detail?id=U000002-010')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-001', N'U000004', N'Lượt lưu mới', N'Bài đăng Lẩu Dê nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:12:03.450' AS DateTime), 0, N'/Post/Detail?id=U000004-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-002', N'U000004', N'Lượt lưu mới', N'Bài đăng Lẩu Mắm - Má Năm nhận được lượt lưu thứ 1.', CAST(N'2022-07-07T20:12:10.763' AS DateTime), 0, N'/Post/Detail?id=U000004-001')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-003', N'U000004', N'Lượt thích mới', N'Bài đăng Lẩu Thái Pallet nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:12.220' AS DateTime), 0, N'/Post/Detail?id=U000004-002')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-004', N'U000004', N'Lượt thích mới', N'Bài đăng Lumos Coffee nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:12:14.247' AS DateTime), 0, N'/Post/Detail?id=U000004-003')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-005', N'U000004', N'Lượt thích mới', N'Bài đăng Lẩu Dê nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:19:54.077' AS DateTime), 0, N'/Post/Detail?id=U000004-007')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-006', N'U000004', N'Lượt thích mới', N'Bài đăng Ốc Nướng Tiêu nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:19:56.157' AS DateTime), 0, N'/Post/Detail?id=U000004-006')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-007', N'U000004', N'Lượt thích mới', N'Bài đăng Nướng Xiên Que Panda nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:19:57.957' AS DateTime), 0, N'/Post/Detail?id=U000004-005')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-008', N'U000004', N'Lượt thích mới', N'Bài đăng Lẩu Nhà Quê nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:19:59.307' AS DateTime), 0, N'/Post/Detail?id=U000004-004')
INSERT [dbo].[ThongBao] ([Ma_TB], [Ma_ND], [Tieu_De], [Noi_Dung], [Thoi_Gian], [Trang_Thai], [Lien_Ket]) VALUES (N'U000004-009', N'U000004', N'Lượt thích mới', N'Bài đăng Vịt Nấu Chao nhận được lượt thích thứ 1.', CAST(N'2022-07-07T20:20:04.747' AS DateTime), 0, N'/Post/Detail?id=U000004-008')
GO
INSERT [dbo].[TinNhan] ([ID], [Nguoi_Gui], [Nguoi_Nhan], [Thoi_Gian], [Noi_Dung], [Trang_Thai], [Lien_Ket]) VALUES (1, N'U000002', N'U000001', CAST(N'2022-06-30T12:10:39.570' AS DateTime), N'Chào bạn', 1, NULL)
INSERT [dbo].[TinNhan] ([ID], [Nguoi_Gui], [Nguoi_Nhan], [Thoi_Gian], [Noi_Dung], [Trang_Thai], [Lien_Ket]) VALUES (2, N'U000002', N'U000001', CAST(N'2022-06-30T13:01:26.743' AS DateTime), N'Cho mình làm quen được không?', 1, NULL)
INSERT [dbo].[TinNhan] ([ID], [Nguoi_Gui], [Nguoi_Nhan], [Thoi_Gian], [Noi_Dung], [Trang_Thai], [Lien_Ket]) VALUES (3, N'U000001', N'U000002', CAST(N'2022-06-30T13:03:38.630' AS DateTime), N'Chào ạ', 1, NULL)
INSERT [dbo].[TinNhan] ([ID], [Nguoi_Gui], [Nguoi_Nhan], [Thoi_Gian], [Noi_Dung], [Trang_Thai], [Lien_Ket]) VALUES (4, N'U000002', N'U000001', CAST(N'2022-06-30T13:03:46.747' AS DateTime), N'Bạn khỏe không?', 0, NULL)
INSERT [dbo].[TinNhan] ([ID], [Nguoi_Gui], [Nguoi_Nhan], [Thoi_Gian], [Noi_Dung], [Trang_Thai], [Lien_Ket]) VALUES (5, N'U000004', N'U000002', CAST(N'2022-07-07T20:13:16.860' AS DateTime), N'Chào bạn', 0, NULL)
GO
