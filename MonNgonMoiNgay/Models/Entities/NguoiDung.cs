using System;
using System.Collections.Generic;

namespace MonNgonMoiNgay.Models.Entities
{
    public partial class NguoiDung
    {
        public NguoiDung()
        {
            BaiDangDuocLuus = new HashSet<BaiDangDuocLuu>();
            BaiDangs = new HashSet<BaiDang>();
            DayBaiDangs = new HashSet<DayBaiDang>();
            PhanHois = new HashSet<PhanHoi>();
            ThongBaos = new HashSet<ThongBao>();
            TinNhanNguoiGuiNavigations = new HashSet<TinNhan>();
            TinNhanNguoiNhanNavigations = new HashSet<TinNhan>();
            YeuThichBaiDangs = new HashSet<YeuThichBaiDang>();
        }

        public string MaNd { get; set; } = null!;
        public string? MaLoai { get; set; }
        public string? HoLot { get; set; }
        public string? Ten { get; set; }
        public DateTime? NgaySinh { get; set; }
        public int? GioiTinh { get; set; }
        public string? Sdt { get; set; }
        public string Email { get; set; } = null!;
        public string MatKhau { get; set; } = null!;
        public string? ImgAvt { get; set; }
        public string? DiaChi { get; set; }
        public bool TrangThai { get; set; }
        public DateTime? NgayTao { get; set; }

        public virtual LoaiNd? MaLoaiNavigation { get; set; }
        public virtual ICollection<BaiDangDuocLuu> BaiDangDuocLuus { get; set; }
        public virtual ICollection<BaiDang> BaiDangs { get; set; }
        public virtual ICollection<DayBaiDang> DayBaiDangs { get; set; }
        public virtual ICollection<PhanHoi> PhanHois { get; set; }
        public virtual ICollection<ThongBao> ThongBaos { get; set; }
        public virtual ICollection<TinNhan> TinNhanNguoiGuiNavigations { get; set; }
        public virtual ICollection<TinNhan> TinNhanNguoiNhanNavigations { get; set; }
        public virtual ICollection<YeuThichBaiDang> YeuThichBaiDangs { get; set; }
    }
}
