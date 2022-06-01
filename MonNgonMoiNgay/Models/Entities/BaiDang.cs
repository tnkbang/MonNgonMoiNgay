using System;
using System.Collections.Generic;

namespace MonNgonMoiNgay.Models.Entities
{
    public partial class BaiDang
    {
        public BaiDang()
        {
            BaiDangDuocLuus = new HashSet<BaiDangDuocLuu>();
            DayBaiDangs = new HashSet<DayBaiDang>();
            HinhAnhs = new HashSet<HinhAnh>();
            YeuThichBaiDangs = new HashSet<YeuThichBaiDang>();
        }

        public string MaBd { get; set; } = null!;
        public string MaLoai { get; set; } = null!;
        public string MaNd { get; set; } = null!;
        public DateTime ThoiGian { get; set; }
        public string TenMon { get; set; } = null!;
        public string? MoTa { get; set; }
        public string ViTri { get; set; } = null!;
        public int TrangThai { get; set; }

        public virtual LoaiMonAn MaLoaiNavigation { get; set; } = null!;
        public virtual NguoiDung MaNdNavigation { get; set; } = null!;
        public virtual ICollection<BaiDangDuocLuu> BaiDangDuocLuus { get; set; }
        public virtual ICollection<DayBaiDang> DayBaiDangs { get; set; }
        public virtual ICollection<HinhAnh> HinhAnhs { get; set; }
        public virtual ICollection<YeuThichBaiDang> YeuThichBaiDangs { get; set; }
    }
}
